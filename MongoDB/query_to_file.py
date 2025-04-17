from functools import wraps
from pprint import pprint
from typing import Iterable


def write_to_file(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        with open("mongo_query.json", "w", encoding="utf-8") as file:
            result = func(*args, **kwargs)
            if isinstance(result, Iterable):
                pprint(list(result), stream=file)
            else:
                pprint(result, stream=file)
    return wrapper