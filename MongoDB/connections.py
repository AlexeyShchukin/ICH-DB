from pymongo import MongoClient

client = MongoClient("mongodb://ich1:password@mongo.edu.itcareerhub.de:27017/?readPreference=primary&ssl=false"
                     "&authMechanism=DEFAULT&authSource=ich")