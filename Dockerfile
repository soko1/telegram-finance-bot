FROM python:3.8

WORKDIR /home

ENV TELEGRAM_API_TOKEN="1165801779:AAGUS7LTbKgKwMGU7p99VN0h3ULFrmKcrGg"
ENV TELEGRAM_ACCESS_ID="106558153"
ENV TELEGRAM_PROXY_URL=""
ENV TELEGRAM_PROXY_LOGIN=""
ENV TELEGRAM_PROXY_PASSWORD=""

ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN pip install -U pip aiogram pytz && apt-get update && apt-get install sqlite3
COPY *.py ./
COPY createdb.sql ./

ENTRYPOINT ["python", "server.py"]

