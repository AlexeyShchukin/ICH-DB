from MongoDB.my_collections import trips, companies, shipwrecks, restaurants, bank_churners, airbnb
from MongoDB.query_to_file import write_to_file


@write_to_file
def get_most_common_age():
    """Найти основную возрастную аудиторию - возраст наиболее активных пользователей"""
    return trips.aggregate([{'$match': {'birth year': {'$ne': ''}}},
                            {'$group': {'_id': '$birth year', 'count_trips': {'$sum': 1}}},
                            {'$sort': {'count_trips': -1}}, {'$limit': 1},
                            {'$project': {'_id': 0, 'age': {'$subtract': [{'$year': '$$NOW'}, '$_id']}}}])


@write_to_file
def get_oldest_company():
    """Найдем самую старую компанию."""
    return companies.aggregate([{'$set': {'founded_date': {'$dateFromParts': {'day': '$founded_day',
                                                                              'month': '$founded_month',
                                                                              'year': '$founded_year'}}}},
                                {'$set': {'age': {'$dateDiff': {'startDate': '$founded_date',
                                                                'endDate': '$$NOW',
                                                                'unit': 'year'}}}},
                                {'$sort': {'age': -1}},
                                {'$limit': 1}])


@write_to_file
def count_missing_ships():
    """Найти все обломки кораблей и пропавшие корабли в Бермудском треугольнике и подсчитать их количество."""
    return shipwrecks.aggregate([{'$match':
                                      {'coordinates':
                                           {'$geoWithin':
                                                {'$geometry':
                                                     {'type': 'Polygon',
                                                      'coordinates': [[[-64.785825, 32.294164],
                                                                       [-66.057884, 18.415753],
                                                                       [-77.323494, 25.046813],
                                                                       [-81.403103, 30.278911],
                                                                       [-64.785825, 32.294164]]]}}}}},
                                 {'$count': 'count'}])


@write_to_file
def count_missing_ships():
    """Из коллекции sample_restaurants.restaurants:
    Найти лучший кошерный ресторан в Бруклине по сумме оценок из отзывов. """
    return restaurants.aggregate([{'$match': {'cuisine': 'Jewish/Kosher', 'borough': 'Brooklyn'}},
                                  {'$unwind': {'path': '$grades'}},
                                  {'$group': {'_id': '$_id',
                                              'total_score': {'$sum': '$grades.score'},
                                              'name': {'$first': '$name'}}},
                                  {'$sort': {'total_score': -1}},
                                  {'$limit': 1},
                                  {'$project': {'_id': 0}}])


@write_to_file
def max_trans_sum():
    """Найти максимальную сумму транзакций (Total_Trans_Amt) среди клиентов в каждой категории Marital_Status."""
    return bank_churners.aggregate([{'$group': {'_id': '$Marital_Status',
                                                'max_amt': {'$max': '$Total_Trans_Amt'}}},
                                    {'$sort': {'max_amt': -1}},
                                    {'$limit': 1}])


@write_to_file
def calculate_percent():
    """5. Для каждого значения Income_Category рассчитать процент клиентов с Attrition_Flag = "Attrited Customer"."""
    return airbnb.aggregate([{'$group':
                                  {'_id': {'income': '$Income_Category',
                                           'attrition': '$Attrition_Flag'},
                                   'cnt': {'$sum': 1}}},
                             {'$group': {'_id': '$_id.income',
                                         'total_customers': {'$sum': '$cnt'},
                                         'attrited_customers': {'$sum': {'$cond': {'if': {'$eq':
                                                                                              ['$_id.attrition',
                                                                                               'Attrited Customer']},
                                                                                   'then': '$cnt', 'else': 0}}}}},
                             {'$project':
                                  {'prcnt': {'$round': [{'$multiply': [{'$divide': ['$attrited_customers',
                                                                                    '$total_customers']}, 100]}, 2]}}}])


@write_to_file
def calculate_percent():
    """Из коллекции sample_airbnb.listingsAndReviews найдите среднюю цену за сутки проживания на Гавайских островах. """
    return airbnb.aggregate([{'$match': {'address.location.coordinates':
                                             {'$geoWithin':
                                                  {'$centerSphere': [[-157.5, 20.5], 250 / 3963.2]}}}},
                             {'$group': {'_id': None,
                                         'avg_price': {'$avg': '$price'}}},
                             {'$project': {'_id': 0,'avg_price': {'$round': ['$avg_price', 2]}}}])
