FROM python:3.10

RUN apt update && apt upgrade -y

RUN curl -sSL https://install.python-poetry.org | python3.10 -
ENV PATH="${PATH}:/root/.local/bin/"

WORKDIR /app

COPY pyproject.toml .
COPY poetry.lock .

RUN --mount=type=secret,id=codeartifact-auth-token \
    poetry config repositories.pyqedma https://qedma-199956927102.d.codeartifact.us-east-1.amazonaws.com/pypi/pyqedma/ && \
    poetry config http-basic.pyqedma aws $(cat /run/secrets/codeartifact-auth-token) && \
    poetry install --no-root --without=dev && \
    poetry config --unset repositories.pyqedma && \
    poetry config --unset http-basic.pyqedma

RUN printf '#!/bin/bash\npoetry run ray "$@"\n' > /usr/bin/ray && chmod +x /usr/bin/ray

COPY . .
RUN poetry install --only-root
