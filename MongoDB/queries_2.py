from MongoDB.my_collections import imdb
from MongoDB.query_to_file import write_to_file


@write_to_file
def get_films_without_directors():
    return imdb.find(filter={"directors": {"$exists": 0}})


@write_to_file
def get_films_by_countries():
    return imdb.find(filter={"countries": {"$in": ["France", "USA"]}})


@write_to_file
def find_films_by_lang():
    return imdb.find(filter={"$or": [{"languages": "Chinese"}, {"languages": "French"}]})


@write_to_file
def find_films_by_languages():
    return imdb.find(filter={"languages": {"$in": ["Chinese", "French"]}})


# in for array = or
@write_to_file
def count_films_by_lang():
    return imdb.count_documents(filter={"$or": [{"languages": "Chinese"}, {"languages": "French"}]})


# all for array = and
@write_to_file
def find_films_by_genre():
    return imdb.find(filter={"genres": {"$all": ["Mystery", "Sci-Fi"]}})


@write_to_file
def show_type_and_runtime():
    return imdb.find(filter={"title": "Berlin Alexanderplatz"}, projection={"runtime": 1, "type": 1, "_id": 0})


@write_to_file
def find_movies_with_two_wins():
    return imdb.find(filter={"type": "movie", "awards": {"$eq": "2 wins."}})


@write_to_file
def count_movies_with_two_wins():
    return imdb.count_documents(filter={"type": "movie", "awards": {"$eq": "2 wins."}})
