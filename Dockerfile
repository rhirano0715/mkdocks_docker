FROM python:latest

WORKDIR /workspace

RUN apt-get update && \
    apt-get -y install git && \
    apt-get clean && \
    pip3 install --upgrade pip && \
    pip3 install mkdocs mkdocs-material fontawesome_markdown
