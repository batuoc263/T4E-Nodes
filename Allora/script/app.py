from flask import Flask, Response
import requests
import json
import random

# create our Flask app
app = Flask(__name__)

CG_Keys = [
    "CG-uKcYkypYQ2toUYg8XSDkZZGQ",
    "CG-r7vNF4Edc3SwwKArrTVgsSUj",
    "CG-n715kFUzxzwimnwv5bcUWYSA",
    "CG-3w7kD2tbWxR6VqwLyYQP11nL",
    "CG-rWhjoS5YQkAmyC4JLfSdUQLg",
    "CG-2ZqHMNu8LJhxKeexeh3Ms1eY",
    "CG-A7D2gXiie4dTnEDuudpn5KJw",
    "CG-FwfH3c3AM5quYShhZnBPREfN",
    "CG-4uhriPpH6bkAWRJ5tmqRKts1",
    "CG-CHi9ArZHNzjfQQk7nPNwonJ4",
    "CG-jpBdHSbwcrJQ3MqSjBqePjdL",
    "CG-3njo2XquKKST3hKRYu9qwdqj",
    "CG-HmhdZy1qr5uhfJz3hbaD4G2p",
    "CG-GYaXKyG2jA7YKYqGgkiQtHQs",
    "CG-d9qnroRMT6a3QHZRpAKtXA25",
    "CG-x1FuKMZFU4NqkjFEKpAj7weo",
    "CG-Xs7Aazo4ebNkgXr21DhQq2Ze",
    "CG-xy49uDA5MKAfaiNFYPanUAEJ",
    "CG-VbwAp9cVGPRWLMyJRGahtT3C",
    "CG-MGtWN3YL7N8bCS7CxgtgRWDN",
    "CG-EB7NZ2odgKm4CdT5J2v3MEEh",
    "CG-S8DKSgwz4oCtanrhC8U2MnZ6"
]

CG_Key = random.choice(CG_Keys)

def get_memecoin_token(blockheight):
    upshot_url = f"https://api.upshot.xyz/v2/allora/tokens-oracle/token/{blockheight}"
    headers = {
        "accept": "application/json",
        "x-api-key": "UP-YOUR-KEY" # replace with your API key
    }   
    
    response = requests.get(upshot_url, headers=headers)
    
    if response.status_code == 200:
        data = response.json()
        name_token = str(data["data"]["token_id"]) #return "boshi"
        return name_token
    else:
        raise ValueError("Unsupported token") 

def get_simple_price(token):
    base_url = "https://api.coingecko.com/api/v3/simple/price?ids="
    token_map = {
        'ETH': 'ethereum',
        'SOL': 'solana',
        'BTC': 'bitcoin',
        'BNB': 'binancecoin',
        'ARB': 'arbitrum'
    }
    token = token.upper()
    if token in token_map:
        url = f"{base_url}{token_map[token]}&vs_currencies=usd"
        headers = {
            "accept": "application/json",
            "x-cg-demo-api-key": CG_Key
        }
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            data = response.json()
            price = data[token_map[token]]["usd"]
            return price
    else:
        raise ValueError("Unsupported token") 
    
    return

@app.route("/collect-price")
def collect_price():
    tokens = [ 'ETH', 'SOL', 'BTC', 'BNB', 'ARB']
    for token in tokens:
        price = get_simple_price(token)
        with open(token + ".txt", "w") as file:
            file.write(str(price))
        
    return Response("Success", status=200, mimetype='application/json')

# define our endpoint
@app.route("/inference/<string:tokenorblockheight>")
def get_inference(tokenorblockheight):
    if tokenorblockheight.isnumeric():
        namecoin = get_memecoin_token(tokenorblockheight)
        price = get_simple_price(namecoin)
    else: 
        try:
            with open(tokenorblockheight + ".txt", "r") as file:
                content = file.read().strip()
            price = float(content)
        except Exception as e:
            return Response(json.dumps({"pipeline error": str(e)}), status=500, mimetype='application/json')
    
    price1 = price + price*0.8/100
    price2 = price - price*0.8/100
    random_float = str(round(random.uniform(price1, price2), 2))
    return random_float

# run our Flask app
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000, debug=True)