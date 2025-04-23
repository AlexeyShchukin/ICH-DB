from pymongo import MongoClient

from dotenv import load_dotenv
import os

load_dotenv()

url = os.getenv("URL")

client = MongoClient(url)


url_edit = os.getenv("URL_ICH_EDIT")
edit_client = MongoClient(url_edit)