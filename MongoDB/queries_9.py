from MongoDB.my_collections import sample_training, bank_churners, airbnb, restaurants, sales
from MongoDB.query_to_file import write_to_file


@write_to_file
def get_max_pop():
    return sample_training.aggregate([{'$setWindowFields': {'output': {'max_pop': {'$max': '$pop'}}}},
                                      {'$match': {'$expr': {'$eq': ['$pop', '$max_pop']}}}])


@write_to_file
def avg_rel_by_buckets():
    return bank_churners.aggregate(
        [{'$bucket': {'groupBy': '$Months_on_book',
                      'boundaries': [0, 25, 49],
                      'default': 49, 'output': {'count_rel': {'$avg': '$Total_Relationship_Count'}}}},
         {'$project': {'count_rel': {'$round': ['$count_rel', 2]}, '_id': 0}}]
    )


@write_to_file
def sort_by_price():
    """з коллекции sample_airbnb.listingsAndReviews отсортировать по цене за ночь недвижимость Барселоны:
    0-50
    50-100
    100-1000
    Дороже 1000"""
    return airbnb.aggregate([{'$match': {'address.market': 'Barcelona'}},
                             {'$bucket': {'groupBy': '$price',
                                          'boundaries': [0, 50, 100, 1000],
                                          'default': 'above 1000',
                                          'output': {'count': {'$sum': 1}}}},
                             {'$sort': {'count': -1}}, {'$limit': 1}])


@write_to_file
def make_new_coll():
    """Создать новую коллекцию reviews и отправить в нее все отзывы из исходной коллекции. 1 документ - 1 отзыв."""
    return airbnb.aggregate([{'$unwind': {'path': '$reviews'}},
                             {'$project': {'_id': 0, 'reviews': 1}},
                             {'$set': {'date': '$reviews.date',
                                       'listing_id': '$reviews.listing_id',
                                       'reviewer_id': '$reviews.reviewer_id',
                                       'reviewer_name': '$reviews.reviewer_name',
                                       'comments': '$reviews.comments'}},
                             {'$project': {'reviews': 0}},
                             {'$out': {'db': 'sample_mflix', 'coll': 'reviews'}}])


@write_to_file
def avg_score_by_buckets():
    """restaurants: выяснить, в каких диапазонах средняя оценка этих ресторанов,
    расположив их по группам [0, 20, 40, 60, 80, 100]
    Таким образом выяснить группу лучших и худших ресторанов."""
    return restaurants.aggregate([{'$match': {'grades': {'$exists': True, '$ne': []}}},
                                  {'$project': {'name': 1, 'avg_score': {'$avg': '$grades.score'}}},
                                  {'$bucket': {'groupBy': '$avg_score',
                                               'boundaries': [0, 20, 40, 60, 80, 100],
                                               'default': 'Other',
                                               'output': {'count': {'$sum': 1},
                                                          'names': {'$push': '$name'}}}}])


@write_to_file
def set_new_fields():
    """Добавить в коллекцию sample_restaurants.restaurants поля: среднее значение
    оценки из отзывов и добавить количество отзывов для удобства."""
    return restaurants.aggregate([{'$set': {'avg_score': {'$avg': '$grades.score'},
                                            'review_count': {'$size': '$grades'}}}])


@write_to_file
def map_func():
    """sales: добавить новое поле - total - итоговая сумма покупки,
    которое состоит из всех элементов items, в котором мы умножаем количество на стоимость одной единицы."""
    return sales.aggregate(
        [{'$project': {'_id': 0,
                       'total': {'$sum': {'$map': {'input': '$items',
                                                   'as': 'total_price',
                                                   'in': {'$multiply': ['$$total_price.price',
                                                                        '$$total_price.quantity']}}}}}}]
    )


@write_to_file
def get_most_active_user():
    """найти самого активного пользователя, который оставил больше всего отзывов."""
    return sales.aggregate([{'$unwind': {'path': '$reviews'}},
                            {'$group': {'_id': '$reviews.reviewer_id',
                                        'count_reviews': {'$sum': 1},
                                        'locations': {'$push': '$name'},
                                        'reviewer': {'$first': '$reviews.reviewer_name'}}},
                            {'$sort': {'count_reviews': -1}},
                            {'$limit': 1}])


@write_to_file
def get_user_transactions():
    """Поищем все транзакции пользователя Lauren Clark."""
    return sales.aggregate([{'$match': {'name': 'Lauren Clark'}},
                            {'$lookup': {'from': 'transactions',
                                         'localField': 'accounts',
                                         'foreignField': 'account_id',
                                         'as': 'cust_trans'}}])


@write_to_file
def get_qty_user_accounts():
    return sales.aggregate([{'$lookup': {'from': 'transactions',
                                         'localField': 'accounts',
                                         'foreignField': 'account_id',
                                         'as': 'cust_trans'}},
                            {'$project': {'_id': 0,
                                          'username': 1,
                                          'name': 1,
                                          'email': 1,
                                          'transactions': '$cust_trans',
                                          'count_accounts': {'$size': '$accounts'}}}])
