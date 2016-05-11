
FROM ubuntu:14.04

RUN apt-get update && apt-get -y install curl python build-essential git libfreetype6 libfontconfig1 firefox xvfb python-pip

RUN curl -sL https://deb.nodesource.com/setup_4.x |  bash -

RUN apt-get -y install nodejs

RUN npm install -g bower gulp 

RUN npm install phantomjs

RUN pip install -r requirements.txt

# Cleaning
RUN apt-get clean  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
