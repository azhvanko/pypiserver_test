FROM python:3.11.7-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ARG USER=pypi
ARG USER_ID=1000
ARG PROJECT_PATH=/pypi

RUN apt-get update -y -q && \
    DEBIAN_FRONTEND=noninteractive && \
    useradd -m -o -u $USER_ID -U -d $PROJECT_PATH -s /bin/bash $USER && \
    python -m pip install --no-cache-dir -U pip setuptools wheel poetry && \
    # cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR ${PROJECT_PATH}

ADD --chown=$USER:$USER pyproject.toml poetry.lock ./

RUN poetry config virtualenvs.create false && \
    poetry install --no-cache --no-interaction

USER $USER
