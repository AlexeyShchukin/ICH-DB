from pymongo import MongoClient

from dotenv import load_dotenv
import os

load_dotenv()

url = os.getenv("URL")

client = MongoClient(url)