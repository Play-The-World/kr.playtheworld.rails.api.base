FROM ruby:3.0.2-alpine

LABEL maintainer="Mechuri mechuri@playthe.world"

WORKDIR /app

ARG BUILD_PACKAGES="build-base gcc libc-dev curl-dev git"
ARG DEV_PACKAGES="zlib-dev yarn libxslt-dev libxml2-dev"
ARG OTHER_PACKAGES="nodejs ca-certificates linux-headers imagemagick file"
ARG RUBY_PACKAGES="mariadb-dev libxml2 libxslt tzdata"

ENV ENABLE_FILE_LOG true
ENV RAILS_ENV=production
ENV RACK_ENV=production
ENV NODE_ENV=production
ENV BUNDLE_APP_CONFIG="/app/.bundle"

WORKDIR /app

# install packages
RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES $OTHER_PACKAGES $RUBY_PACKAGES

COPY . .

# Configure bundler
# RUN bundler config --global frozen 1
RUN bundle config build.nokogiri --use-system-libraries \
        --with-xml2-config=/usr/bin/xml2-config \
        --with-xslt-config=/usr/bin/xslt-config \
    && bundle config set without 'development:test:assets' \
    && bundle config set path 'vendor/bundle' \
    && bundle install

RUN apk del $BUILD_PACKAGES $DEV_PACKAGES

EXPOSE 3000
ENTRYPOINT ["sh", "./start-up.sh"]
VOLUME ["/app/log"]