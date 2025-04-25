from MongoDB.my_collections import imdb
from query_to_file import write_to_file


# Сгруппировать количество фильмов по годам между 1980 и 1990. Отсортировать по годам, по возрастанию.
@write_to_file
def group_by_years():
    return imdb.aggregate([{'$set': {'int_year': {'$toInt': '$year'}}},
                           {'$group': {'_id': '$int_year', 'count_films': {'$sum': 1}}},
                           {'$match': {'_id': {'$gt': 1980, '$lt': 1990}}},
                           {'$sort': {'_id': 1}}])


# Найти 3 самые популярные группы стран из списка всех фильмов.
@write_to_file
def most_popular_countries():
    return imdb.aggregate([{'$group': {'_id': '$countries', 'count_films': {'$sum': 1}}},
                           {'$sort': {'count_films': -1}},
                           {'$limit': 3}])


# Найти 3 самые популярные группы стран из списка всех фильмов по среднему рейтингу фильмов в группе стран.
@write_to_file
def most_popular_countries_by_rate():
    return imdb.aggregate([{"$unwind": "$countries"},
                           {"$group": {"_id": "$countries", "avg_rating": {"$avg": "$imdb.rating"}}},
                           {"$sort": {"avg_rating": -1}},
                           {"$limit": 3}])
