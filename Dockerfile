
FROM ubuntu:14.04

RUN apt-get update && apt-get -y install curl python python-dev build-essential git libfreetype6 libfontconfig1 libffi-dev libssl-dev firefox xvfb python-pip wget

# Install Firefox ESR and configure it to be used as default firefox installation.

RUN wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/45.5.1esr/linux-x86_64/en-US/firefox-45.5.1esr.tar.bz2

RUN tar -xvjf firefox-45.5.1esr.tar.bz2 -C /opt

RUN mv /usr/bin/firefox /usr/bin/firefox-old

RUN ln -s /opt/firefox/firefox /usr/bin/firefox

RUN curl -sL https://deb.nodesource.com/setup_4.x |  bash -

RUN apt-get -y install nodejs

RUN npm install -g bower gulp

RUN npm install phantomjs

COPY requirements.txt .

RUN pip install -r requirements.txt

# Cleaning
RUN apt-get clean  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
