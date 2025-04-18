from MongoDB.my_collections import imdb, parkings
from MongoDB.query_to_file import write_to_file


@write_to_file
def find_by_year_and_type():
    return imdb.find(
        filter={"year": "1989", "type": "movie"},
        projection={"_id": 0, "title": 1, "year": 1, "type": 1, "imdb.rating": 1},
        sort={"imdb.rating": -1},
        limit=10
    )


@write_to_file
def get_avg_fuel_by_engine():
    return parkings.aggregate([{"$group": {"_id": "$engineType", "avg_fuel": {"$avg": "$fuel"}}}])


@write_to_file
def get_duration():
    return parkings.aggregate(
        [
            {'$set': {'duration': {'$subtract': ['$final_time', '$init_time']}}},
            {'$match': {'duration': {'$gt': 300}}},
            {'$count': 'count_dur_gt_300'}
        ]
    )


@write_to_file
def count_in_groups_by_city_and_interior():
    return parkings.aggregate(
        [
            {'$group': {'_id': {'city': '$city', 'interior': '$interior'},
                        'count_cars': {'$sum': 1}}},
            {'$count': 'count_cars'}
        ]
    )


@write_to_file
def sort_by_fuel():
    return parkings.aggregate([{'$sort': {'fuel': -1}}])


@write_to_file
def add_field_year():
    return parkings.aggregate([{'$addFields': {'year': {'$year': '$init_date'}}}])


@write_to_file
def add_field_year():
    return parkings.aggregate([{'$project': {'plate': 1, 'coordinates': '$loc.coordinates', '_id': 0}}])


@write_to_file
def count_unique_engines():
    return parkings.aggregate(
        [
            {"$match": {"engineType": {"$exists": True}}},
            {"$group": {"_id": "$engineType"}},
            {"$count": "count_doc"}
        ]
    )

