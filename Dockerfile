FROM ubuntu:16.04

ARG BUILD_PACKAGES="build-essential wget"

ENV FIREFOX_ESR 45.5.1esr
ENV NODE_VERSION v4.7.3

COPY requirements.txt /tmp/

RUN apt-get update && apt-get install -y \
        ${BUILD_PACKAGES} \
        git \
        firefox \
        libffi-dev \
        libfontconfig1 \
        libfreetype6 \
        libssl-dev \
        python-dev \
        python-pip \
        xvfb \

    # Node + npm.
    && wget http://nodejs.org/dist/$NODE_VERSION/node-$NODE_VERSION-linux-x64.tar.gz \
    && tar -C /usr/local --strip-components 1 -xzf node-$NODE_VERSION-linux-x64.tar.gz \
    && rm node-$NODE_VERSION-linux-x64.tar.gz \

    # Npm packages. Phamtomjs must be installed as non global.
    && npm install -g bower gulp \
    && npm install phantomjs \

    && pip install --requirement /tmp/requirements.txt \

    # Install Firefox ESR and configure it to be used as default firefox installation.
    && wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/$FIREFOX_ESR/linux-x86_64/en-US/firefox-$FIREFOX_ESR.tar.bz2 \
    && tar -xvjf firefox-$FIREFOX_ESR.tar.bz2 -C /opt \
    && mv /usr/bin/firefox /usr/bin/firefox-old \
    && rm -r /usr/bin/firefox-old \
    && ln -s /opt/firefox/firefox /usr/bin/firefox \
    && rm firefox-$FIREFOX_ESR.tar.bz2 \

    # Cleanup
    && apt-get remove --purge -y ${BUILD_PACKAGES} && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* /var/tmp/*
