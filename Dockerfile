FROM python:3.10

RUN apt update && apt upgrade -y

RUN curl -sSL https://install.python-poetry.org | python3.10 -
ENV PATH="${PATH}:/root/.local/bin/"

WORKDIR /app

COPY . .
RUN poetry install
