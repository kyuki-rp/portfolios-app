from fastapi import FastAPI
from pydantic import BaseModel
from numpy import random
import pandas as pd
import datetime
from starlette.middleware.cors import CORSMiddleware

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"]
)

class Value(BaseModel):
    your_zodiac_sign: str

@app.get("/")
async def hello():
    return {"message": "hello world!"}

subdirectry = 'zodiac-api'

@app.post(f"/{subdirectry}/view_one")
async def create_user(value:Value):
    dt = datetime.datetime.now()
    random.seed(int(f"{dt.year}{dt.month}{dt.day}"))

    # レスポンスbody   
    scores = random.rand(12) *100
    zodiac_signs = ["おひつじ座","おうし座","ふたご座","かに座","しし座","おとめ座","てんびん座","さそり座","いて座","やぎ座","みずがめ座","うお座"]  
    df = pd.DataFrame({"score":scores,"zodiac_sign":["おひつじ座","おうし座","ふたご座","かに座","しし座","おとめ座","てんびん座","さそり座","いて座","やぎ座","みずがめ座","うお座"]})
    df["score"] = df["score"].apply(int)
    df["rank"] = df["score"].rank(ascending=False, method='min')
    df["star"] = (df["score"]/20).apply(int).map({0:"☆",1:"☆☆",2:"☆☆☆",3:"☆☆☆☆",4:"☆☆☆☆☆"})
    df["description"] = df["zodiac_sign"] + "のあなたは" + (df["star"]).map({"☆":"逆にまあまあ","☆☆":"まあまあ","☆☆☆":"そこそこまあまあ","☆☆☆☆":"かなりまあまあ","☆☆☆☆☆":"全力でまあまあ"})
    df = df.sort_values('score', ascending=False)
    result = df.to_dict(orient='records')

    description = df[df["zodiac_sign"]==value.your_zodiac_sign].to_dict(orient='records')[0]["description"]
    star = df[df["zodiac_sign"]==value.your_zodiac_sign].to_dict(orient='records')[0]["star"]

    return {"status": "200", "description":description, "star":star}

# シンプルなJSON Bodyの受け取り
@app.get(f"/{subdirectry}/view_all")
def create_user():
    dt = datetime.datetime.now()
    random.seed(int(f"{dt.year}{dt.month}{dt.day}"))

    # レスポンスbody   
    scores = random.rand(12) *100
    zodiac_signs = ["おひつじ座","おうし座","ふたご座","かに座","しし座","おとめ座","てんびん座","さそり座","いて座","やぎ座","みずがめ座","うお座"]  
    df = pd.DataFrame({"score":scores,"zodiac_sign":["おひつじ座","おうし座","ふたご座","かに座","しし座","おとめ座","てんびん座","さそり座","いて座","やぎ座","みずがめ座","うお座"]})
    df["score"] = df["score"].apply(int)
    df["rank"] = df["score"].rank(ascending=False, method='min')
    df["star"] = (df["score"]/20).apply(int).map({0:"☆",1:"☆☆",2:"☆☆☆",3:"☆☆☆☆",4:"☆☆☆☆☆"})
    df["description"] = df["zodiac_sign"] + "のあなたは" + (df["star"]).map({"☆":"逆にまあまあ","☆☆":"まあまあ","☆☆☆":"そこそこまあまあ","☆☆☆☆":"かなりまあまあ","☆☆☆☆☆":"全力でまあまあ"})
    df = df.sort_values('score', ascending=False)
    result = df.to_dict(orient='records')
    
    return {"status": "200", "main":result}

# class TestParam(BaseModel):
#     param1 : str
    
# @app.post("/")
# def post_root(testParam : TestParam):
#     print(testParam)
#     return testParam
