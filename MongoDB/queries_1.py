from MongoDB.my_collections import spotify_youtube, imdb, customers, trips
from query_to_file import write_to_file


@write_to_file
def find_customer():
    return customers.find_one({"ContactName": "Sven Ottlieb"})


@write_to_file
def find_trips():
    return trips.find(filter={},
                      projection={"tripduration": 1, "_id": 0},
                      sort={"tripduration": -1},
                      limit=3)


@write_to_file
def find_songs_artist():
    return spotify_youtube.find({"Artist": {"$in": ["Adele", "Drake", "Doja Cat"]}})


@write_to_file
def find_songs_by_track():
    return spotify_youtube.find({"Track": {"$regex": "love", "$options": "i"}},
                                {"Track": 1, "_id": 0})


@write_to_file
def group_bikes():
    return trips.aggregate([
        {"$group":
             {"_id": "$bikeid",
              "count": {"$sum": 1}
              }},
        {"$sort": {"count": -1}},
        {"$limit": 1}
    ])


@write_to_file
def find_tomatoes():
    return imdb.find(filter={"tomatoes": {"$exists": "true"},
                             "tomatoes.viewer.rating": {"$gt": 4.5}},
                     projection={"_id": 0, "title": 1, "year": 1},
                     sort={"year": 1, "title": -1},
                     limit=10)
find_tomatoes()

@write_to_file
def count_tomatoes():
    return imdb.count_documents({"tomatoes": {"$exists": "true"}, "tomatoes.viewer.rating": {"$gt": 4.5}})


@write_to_file
def find_genres():
    return imdb.find(filter={"genres": {"$all": ["Drama", "Fantasy"]}, "countries": "USA"},
                     projection={"plot": 1, "title": 1, "_id": 0, "runtime": 1},
                     sort={"runtime": -1})


@write_to_file
def find_by_years():
    return imdb.aggregate([
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
    ])

