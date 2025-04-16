import json

from MongoDB.my_collections import spotify_youtube, imdb
from my_collections import customers, trips
from pprint import pprint


def find_customer():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint(customers.find_one({"ContactName": "Sven Ottlieb"}), stream=file)


def find_trips():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([trip for trip in trips.find(filter={},
                                            projection={"tripduration": 1, "_id": 0},
                                            sort={"tripduration": -1},
                                            limit=3)],
               stream=file)


def find_songs_artist():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([song for song in spotify_youtube.find({"Artist": {"$in": ["Adele", "Drake", "Doja Cat"]}})],
               stream=file)


def find_songs_by_track():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([song for song in spotify_youtube.find({"Track": {"$regex": "love", "$options": "i"}},
                                                      {"Track": 1, "_id": 0})],
               stream=file)


def group_bikes():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([bike for bike in trips.aggregate([
            {"$group":
                 {"_id": "$bikeid",
                  "count": {"$sum": 1}
                  }},
            {"$sort": {"count": -1}},
            {"$limit": 1}
        ])], stream=file)


def find_tomatoes():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([obj for obj in imdb.find(filter={"tomatoes": {"$exists": "true"},
                                                 "tomatoes.viewer.rating": {"$gt": 4.5}},
                                         projection={"_id": 0, "title": 1, "year": 1},
                                         sort={"year": 1, "title": -1},
                                         limit=10)], stream=file)


def count_tomatoes():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        print(imdb.count_documents({"tomatoes": {"$exists": "true"}, "tomatoes.viewer.rating": {"$gt": 4.5}}),
              file=file)


def find_genres():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([obj for obj in imdb.find(filter={"genres": {"$all": ["Drama", "Fantasy"]}, "countries": "USA"},
                                         projection={"plot": 1, "title": 1, "_id": 0, "runtime": 1},
                                         sort={"runtime": -1})], stream=file, indent=4)


def find_by_years():
    with open("mongo_query.txt", "w", encoding="utf-8") as file:
        pprint([obj for obj in imdb.aggregate([
            {
                "$set":
                    {
                        "year_int": {
                            "$toInt": "$year"
                        }
                    }
            },
            {
                "$match":
                    {
                        "year_int": {
                            "$gte": 1900,
                            "$lte": 1910
                        },
                        "imdb.rating": {
                            "$gt": 7
                        },
                        "awards": {
                            "$exists": True
                        }
                    }
            },
            {
                "$sort":
                    {
                        "imdb.rating": 1
                    }
            },
            {
                "$project":
                    {
                        "title": 1,
                        "year": 1,
                        "runtime": 1,
                        "_id": 0
                    }
            }
        ])], stream=file, indent=4)

