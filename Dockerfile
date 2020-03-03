FROM ruby:2.7.0-alpine

MAINTAINER Mechuri mechuri@playthe.world

# ENV NODE_VERSION 11.15.1

RUN apk add --no-cache --update \
    ca-certificates \
    linux-headers \
    build-base \
    libxml2-dev \
    libxslt-dev \
    tzdata \
    git

RUN gem install bundler \
    && bundler config --global frozen 1

WORKDIR /app

ENV RAILS_ENV production
ENV RACK_ENV production
ENV ENABLE_FILE_LOG true

RUN git init && git submodule init && git submodule update

# Node 모듈 설치
# COPY package.json yarn.lock ./
# RUN yarn install --production

# Gem 모듈 설치
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 레일즈 앱 전체 복사
COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

VOLUME ["/app/storage", "/app/log"]