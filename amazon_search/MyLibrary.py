import requests as rq
import datetime
import json
dt = datetime.datetime


class MyLibrary:
    def __init__(self):
        pass

    def convert_value(self, value):
        # Function to convert USD to BRL
        url = "https://api.exchangeratesapi.io/latest?base=USD"
        response = rq.get(url)
        json_obj = json.loads(response.text)
        brl = float(json_obj['rates']['BRL'])
        return brl*value
