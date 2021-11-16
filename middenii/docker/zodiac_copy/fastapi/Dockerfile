# python3.9のイメージをダウンロード
FROM python:3.9-buster
ENV PYTHONUNBUFFERED=1

WORKDIR /src

# pipを使ってpoetryをインストール
RUN pip install fastapi
RUN pip install uvicorn
RUN pip install pandas

# FastAPIを8000ポートで待機
ENTRYPOINT ["uvicorn", "api.main:app", "--reload", "--host", "0.0.0.0", "--port", "8000"]
