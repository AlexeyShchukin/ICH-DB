import json

from MongoDB.my_collections import spotify_youtube
from my_collections import customers, trips
from pprint import pprint

pprint(customers.find_one({"ContactName": "Sven Ottlieb"}))

qry = trips.find({}, {"tripduration": 1, "_id": 0}).sort({"tripduration": -1}).limit(3)
obj = json.dumps(list(qry))
print(obj)

# db['companies'].find(
#   filter={
#     'total_money_raised': RegExp("^\\$.*B$")
# },
#   projection={total_money_raised: 1},
#   sort={total_money_raised: -1},
# ).limit(1)
#
# db["Spotify_Youtube"].find(filter={official_video: true, Views: {$gt: 10000000}})
#
# db["Spotify_Youtube"].find(filter={Artist: "Taylor Swift", Danceability: {$gt: 0.7}})
#
# db["Spotify_Youtube"].find(filter={$or: [{Likes: {$gt: 1000000}},
# {Comments: {$gt: 10000}}]}, projection={Likes: 1, Comments: 1, _id: 0})


# qry1 = spotify_youtube.find({"official_video": True,
#                              "Artist": "The Weeknd"}).sort({"Likes": -1}).limit(5)
# for obj in qry1:
#     print(obj)

pprint([song for song in spotify_youtube.find({"Artist": {"$in": ["Adele", "Drake", "Doja Cat"]}})])

pprint([song for song in spotify_youtube.find({"Track": {"$regex": "love", "$options": "i"}}, {"Track": 1, "_id": 0})])
pprint([bike for bike in trips.aggregate([
    {"$group":
         {"_id": "$bikeid",
          "count": {"$sum": 1}
          }},
    {"$sort": {"count": -1}},
    {"$limit": 1}
])])
