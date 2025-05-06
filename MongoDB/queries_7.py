from my_collections import bank_churners
from query_to_file import write_to_file


@write_to_file
def avg_age():
    """Выводит средний возраст клиентов"""
    return bank_churners.aggregate([{'$group': {'_id': None, 'avg_age': {'$avg': '$Customer_Age'}}},
                                    {'$project': {'_id': 0, 'avg_age': {'$round': ['$avg_age', 1]}}}])


@write_to_file
def greatest_avg_rel():
    """Категория клиентов по доходу с самым высоким средним количеством отношений"""
    return bank_churners.aggregate([{'$group': {'_id': '$Income_Category',
                                                'avg_rel': {'$avg': '$Total_Relationship_Count'}}},
                                    {'$sort': {'avg_rel': -1}}, {'$limit': 1},
                                    {'$project': {'avg_rel': {'$round': ['$avg_rel', 1]}}}])


@write_to_file
def avg_cred_lim_by_gender():
    return bank_churners.aggregate([{'$group': {'_id': '$Gender', 'avg_cred_lim': {'$avg': '$Credit_Limit'}}},
                                    {'$project': {'avg_cred_lim': {'$round': ['$avg_cred_lim', 1]}}}])


@write_to_file
def count_customers():
    """Количество клиентов, у которых Total_Revolving_Bal ниже чем Credit_Limit."""
    return bank_churners.aggregate([{'$match': {'$expr': {'$lt': ['$Total_Revolving_Bal', '$Credit_Limit']}}},
                                    {'$count': 'cnt'}])


@write_to_file
def create_buckets_by_age():
    return bank_churners.aggregate([{'$bucket': {'groupBy': '$Customer_Age',
                                                 'boundaries': [20, 30, 40, 50, 60],
                                                 'default': 'other',
                                                 'output': {'avg_trans_ct': {'$avg': '$Total_Trans_Ct'}}}}])
