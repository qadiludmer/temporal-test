FROM python:3.10-slim

RUN apt update && apt upgrade -y

RUN curl -sSL https://install.python-poetry.org | python3.10 -
ENV PATH="${PATH}:/root/.local/bin/"

WORKDIR /app

COPY ./poetry.lock .
COPY ./pyproject.toml .
COPY ./temporal_test ./temporal_test
COPY ./README.md .

RUN poetry install
