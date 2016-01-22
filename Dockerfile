FROM phusion/baseimage:0.9.18
MAINTAINER Scott Dial <scott@scottdial.com>

ENV PEN_VERSION="0.32.0"

RUN apt-get update && \
    apt-get -qq install -y \
      build-essential \
      gcc \
      gettext \
      wget \
      && \
    wget -q "http://siag.nu/pub/pen/pen-$PEN_VERSION.tar.gz" -P /tmp && \
    tar xfz "/tmp/pen-$PEN_VERSION.tar.gz" -C / && \
    cd "/pen-$PEN_VERSION" && \
    ./configure && \
    make && \
    make install && \
    rm -rf "/pen-$PEN_VERSION" && \
    apt-get -qq autoremove --purge -y && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
