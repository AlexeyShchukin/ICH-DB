from functools import wraps
from time import perf_counter, strftime


def time_counter(func):
    @wraps(func)
    def decorator(*args, **kwargs):
        start = perf_counter()
        # print("======== Script started ========")
        result = func(*args, **kwargs)
        # print(f"Time end: {strftime('%X')}")
        print(f'======== Script execution time: {perf_counter() - start:.10f} ========')
        return result
    return decorator