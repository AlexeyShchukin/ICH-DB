from MongoDB.my_collections import sample_training, bank_churners
from MongoDB.query_to_file import write_to_file


@write_to_file
def get_max_pop():
    return sample_training.aggregate([{'$setWindowFields': {'output': {'max_pop': {'$max': '$pop'}}}},
                                      {'$match': {'$expr': {'$eq': ['$pop', '$max_pop']}}}])


@write_to_file
def avg_rel_by_buckets():
    return bank_churners.aggregate(
        [{'$bucket': {'groupBy': '$Months_on_book',
                      'boundaries': [0, 25, 49],
                      'default': 49, 'output': {'count_rel': {'$avg': '$Total_Relationship_Count'}}}},
         {'$project': {'count_rel': {'$round': ['$count_rel', 2]}, '_id': 0}}]
    )
