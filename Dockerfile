# Use an official Python runtime as a parent image
FROM python:3.10-slim

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y git \
    openssh-client

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN git config --global user.name "StephCurry07" && git config --global user.email "apoorv.gupta65@gmail.com"

RUN chmod +x git-auto.sh

CMD ["./git-auto.sh"]
