FROM python:3.8-alpine

WORKDIR /app

# コンテナ内で必要なパッケージをインストール
RUN pip install fastapi
RUN pip install uvicorn
RUN pip install pandas

# FastAPIを8000ポートで待機
ENTRYPOINT ["uvicorn", "api.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]