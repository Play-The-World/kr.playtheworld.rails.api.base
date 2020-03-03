# this is our first build stage, it will not persist in the final image
FROM alpine as intermediate

# install git
RUN apk add --no-cache --update \
    git \
    openssh

# add credentials on build
ARG SSH_PRIVATE_KEY
RUN mkdir /root/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

# make sure your domain is accepted
RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# RUN git clone https://github.com/Play-The-World/kr.playtheworld.rails.api.base app
RUN git clone git@github.com:Play-The-World/kr.playtheworld.rails.api.base.git app

RUN git submodule init && git submodule update

FROM ruby:2.7.0-alpine
# copy the repository form the previous image
COPY --from=intermediate /app /app

MAINTAINER Mechuri "mechuri@playthe.world"

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

# Node 모듈 설치
# COPY package.json yarn.lock ./
# RUN yarn install --production

# Gem 모듈 설치
# COPY Gemfile Gemfile.lock ./
# RUN bundle install
# 레일즈 앱 전체 복사
# COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

VOLUME ["/app/storage", "/app/log"]

RUN rm /root/.ssh/id_rsa