FROM adoptopenjdk/openjdk8:jdk8u272-b10-alpine

LABEL maintainer="ccfiel@bai.ph" version="2.0.2"

RUN apk update
RUN apk upgrade
RUN apk add wget tar unzip bash
RUN apk add --virtual build-dependencies build-base gcc wget git

ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc

          
RUN pip install firebase-admin
RUN pip install google-cloud-storage
RUN pip install google-cloud-firestore
RUN gem install fastlane -NV
RUN gem install google-api-client
          
