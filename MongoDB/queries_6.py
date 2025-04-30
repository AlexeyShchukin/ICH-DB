from my_collections import movies, students, airbnb, bank_churners
from query_to_file import write_to_file


@write_to_file
def most_common_genres():
    """Find 5 most common genres"""
    return movies.aggregate([{'$unwind': {'path': '$genres'}},
                             {'$group': {'_id': '$genres', 'count_films': {'$sum': 1}}},
                             {'$sort': {'count_films': -1}},
                             {'$limit': 5}])


@write_to_file
def find_words_in_document():
    """Find case-insensitive words "action" and "adventure" in documents"""
    return movies.find({"$text": {"$search": "action adventure", "$caseSensitive": False}})


@write_to_file
def move_data_to_new_collection():
    """Creating new collection with data from current collection"""
    return students.aggregate([{'$match': {'year': 6}},
                               {'$project': {'sID': 1, 'name': 1, 'score': 1, '_id': 0}},
                               {'$out': {'db': 'ich_edit', 'coll': 'graduate_091224_Alexey'}}])


def get_objects_by_price():
    """Find the 100 most expensive properties in New York and move them to a newly created collection."""
    return airbnb.aggregate([{'$match': {'address.market': 'New York'}},
                             {'$sort': {'price': -1}},
                             {'$limit': 100},
                             {'$out': {'db': 'sample_mflix', 'coll': 'airbnb_New_York_100'}}])


@write_to_file
def get_obj_by_bedrooms():
    """Find property name with max bedrooms quantity"""
    return airbnb.aggregate([{'$sort': {'bedrooms': -1}},
                             {'$limit': 1},
                             {'$project': {'name': 1, '_id': 0}}])


@write_to_file
def get_obj_by_rating():
    """Найти недвижимость с самым высоким рейтингом review_scores_rating при минимальном
    количестве отзывов 50 (number_of_reviews) и напишите ее название"""
    return airbnb.find(filter={"number_of_reviews": {"$gte": 50}},
                       projection={"name": 1, "_id": 0},
                       sort={"review_scores.review_scores_rating": -1},
                       limit=1)


def create_index():
    return bank_churners.create_index([("Education_Level", "text")])
