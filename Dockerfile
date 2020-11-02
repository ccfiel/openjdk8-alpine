FROM adoptopenjdk/openjdk8:jdk8u272-b10-alpine

LABEL maintainer="ccfiel@bai.ph" version="2.0.2"

RUN apk update
RUN apk upgrade
RUN apk add wget tar unzip bash
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

ADD gemrc /root/.gemrc

RUN apk update \
&& apk add ruby \
           ruby-etc \
           ruby-bigdecimal \
           ruby-io-console \
           ruby-irb \
           ca-certificates \
           libressl \
           less \
&& apk add --virtual .build-dependencies \
           build-base \
           ruby-dev \
           libressl-dev \
&& gem install bundler || apk add ruby-bundler \
&& bundle config build.nokogiri --use-system-libraries \
&& bundle config git.allow_insecure true \
&& gem install json \
\
&& gem cleanup \
&& apk del .build-dependencies \
&& rm -rf /usr/lib/ruby/gems/*/cache/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*
          
RUN pip install firebase-admin
RUN pip install google-cloud-storage
RUN pip install google-cloud-firestore
RUN gem install fastlane -NV
RUN gem install google-api-client
          
