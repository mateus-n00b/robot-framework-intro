# Library created to provide the required functions to our tests
import requests as rq
import datetime
import json
from selectorlib import Extractor
from robot.api.deco import keyword, library
dt = datetime.datetime

e = Extractor.from_yaml_file("amazon_search/search_results.yaml")

@library
class MyLibrary(object):
    def __init__(self):
        pass

    @keyword
    def convert_value(self, value, to_usd=True):  # Function to convert BRL to USD and vice-versa
        value = float(value)
        # API call
        url = "https://api.exchangeratesapi.io/latest?base=USD"
        response = rq.get(url)
        json_obj = json.loads(response.text)
        brl = float(json_obj['rates']['BRL'])
        total = "%.2f" % (value/brl) if to_usd else "%.2f" % (value*brl)
        return float(total)

    def scrape(self, html):
        e.extract(html)
        return e.extract(html)

    @keyword
    def is_product(self, html):  # look for the searched products
        # results are saved into .json file
        with open('search_results_output.json', 'w') as outfile:
            data = self.scrape(str(html))
            if data:
                    for product in data['products']:
                        if "iphone" in product['title']:
                            json.dump(product, outfile)
                            outfile.write("\n")
        return True

    @keyword
    def is_cheap(self, html, price_limit_usd):
        # results are saved into .json file
        with open('search_price_output.json', 'w') as outfile:
            data = self.scrape(str(html))
            if data:
                for product in data['products']:
                    if product['price'] and "Iphone" in product['title']:
                        price = product['price'].strip("R$").replace('.', '').replace(',', '.')
                        print("Price in BRL: ", price)
                        price_usd = self.convert_value(float(price))
                        print("Price in USD: ", price_usd)
                        if price_usd <= float(price_limit_usd):
                            json.dump(product, outfile)
                            outfile.write("\n")
        return True

    # Returns the cheapest product
    def cheapest_product(self, html, limit_price_usd=2000):
        data = self.scrape(str(html))
        if data:
            cheapest_product_price = self.convert_value(limit_price_usd, to_usd=False)  # Get in BRL

            for product in data['products']:
                if product['price'] and "Apple" in product['title']:
                    price = product['price'].strip("R$").replace('.', '').replace(',', '.')
                    price = float(price)
                    if price < cheapest_product_price:
                        cheapest_product_price = price
            return cheapest_product_price

    @keyword
    def cheaper_than(self, html):
        # results are saved into .json file
        with open('products_cheaper_than.json', 'w') as outfile:
            data = self.scrape(str(html))
            if data:
                cheapest_price = self.cheapest_product(html)
                print("Cheapest price is: R$", cheapest_price)
                for product in data['products']:  # iterates over each product
                    if product['price'] and "Iphone" not in product['title']:
                        price = product['price'].strip("R$").replace('.', '').replace(',', '.')
                        print("Price in BRL: ", price)
                        price = float(price)
                        if price < cheapest_price: # It's cheaper than...?
                            json.dump(product, outfile)
                            outfile.write("\n")
        return True
