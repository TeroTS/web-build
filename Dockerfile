FROM ubuntu:16.04

ENV FIREFOX_ESR 45.5.1esr

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    firefox \
    git \
    libfontconfig1 \
    libffi-dev \
    libfreetype6 \
    libssl-dev \
    python \
    python-dev \
    python-pip \
    wget \
    xvfb

# NodeSource Node.js Binary Distribution.
RUN curl -sL https://deb.nodesource.com/setup_4.x |  bash -

# Node + npm. Phamtomjs must be installed as non global.
RUN apt-get -y install nodejs \
    && npm install -g bower gulp \
    && npm install phantomjs \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt

# Install Firefox ESR and configure it to be used as default firefox installation.
RUN wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_ESR/linux-x86_64/en-US/firefox-$FIREFOX_ESR.tar.bz2 \
    && tar -xvjf firefox-$FIREFOX_ESR.tar.bz2 -C /opt \
    && mv /usr/bin/firefox /usr/bin/firefox-old \
    && rm -r /usr/bin/firefox-old \
    && ln -s /opt/firefox/firefox /usr/bin/firefox \
    && rm firefox-$FIREFOX_ESR.tar.bz2

# Cleaning.
RUN rm -rf /tmp/* /var/tmp/*
