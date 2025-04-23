# from random import choice, randint
#
# from faker import Faker

from MongoDB.databases import db_ich_edit
from MongoDB.my_collections import bookings
from query_to_file import write_to_file
from gen_docs import user_data
from time_counter import time_counter

# fake = Faker()


# @time_counter
# def create_users_in_loop():
#     for i in range(1, 1001):
#         db_ich_edit.users_091224.insert_one(
#             {
#                 "id": i,
#                 "name": fake.name(),
#                 "age": randint(18, 100),
#                 "gender": choice(["m", "f"]),
#             }
#         )


@time_counter
def create_users():
    db_ich_edit.users_091224.insert_many(user_data)


@write_to_file
def get_users():
    return db_ich_edit.users_091224.find(filter={}, limit=10)


def drop_users():
    return db_ich_edit.users_091224.drop()


@write_to_file
def count_by_gender():
    return db_ich_edit.users_091224.aggregate([{'$group': {'_id': '$gender', 'count': {'$sum': 1}}}])


@write_to_file
def ang_distance_by_vendor():
    return bookings.aggregate([{'$group': {'_id': '$vendor', 'avg_distance': {'$avg': '$distance'}}},
                               {'$project': {'_id': 1, 'avg_dist': {'$round': ['$avg_distance', 2]}}}])

