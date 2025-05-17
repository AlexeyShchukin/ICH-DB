from MongoDB.my_collections import UK_used_cars, bookings
from MongoDB.query_to_file import write_to_file


@write_to_file
def make_buckets_by_price():
    return UK_used_cars.aggregate(
        [{'$match': {'fuelType': 'Diesel'}},
         {'$bucket': {'groupBy': '$price',
                      'boundaries': [0, 20000, 30000, 40000, 60000],
                      'default': 'above 60000'}},
         {'$project': {'price': {'$switch': {'branches': [{'case': {'$eq': ['$_id', 0]},
                                                           'then': '0-19999'},
                                                          {'case': {'$eq': ['$_id', 20000]},
                                                           'then': '20000-29999'},
                                                          {'case': {'$eq': ['$_id', 30000]},
                                                           'then': '30000-39999'},
                                                          {'case': {'$eq': ['$_id', 40000]},
                                                           'then': '40000-49999'}],
                                             'default': 'above 60000'}},
                       '_id': 0,
                       'count': 1}},
         {'$sort': {'count': -1}},
         {'$limit': 1}])


@write_to_file
def f1():
    return bookings.aggregate([{'$match': {'$expr': {'$lt': ['$public_transport.duration', '$driving.duration']},
                                           'public_transport.duration': {'$ne': -1}}},
                               {'$project': {'pt_dur': '$public_transport.duration', 'd_dur': '$driving.duration'}},
                               {'$count': 'string'}])


@write_to_file
def f2():
    return bookings.aggregate(
        [{'$addFields': {'total_distance': {'$add': ['$driving.distance',
                                                     '$walking.distance',
                                                     '$public_transport.distance']},
                         'avg_distance': {'$avg': ['$driving.distance',
                                                   '$walking.distance',
                                                   '$public_transport.distance']}}}])


@write_to_file
def get_hour_from_date():
    return bookings.aggregate([{'$addFields': {'start_hour': {'$hour': '$init_date'}}},
                               {'$group': {'_id': '$start_hour', 'cars_amount': {'$sum': 1}}},
                               {'$sort': {'cars_amount': -1}}])
