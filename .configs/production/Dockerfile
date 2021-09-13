FROM 947202957156.dkr.ecr.ap-northeast-2.amazonaws.com/playtheworld/rails:latest

LABEL maintainer="Mechuri mechuri@playthe.world"

WORKDIR /app

ENV ENABLE_FILE_LOG true
# ENV BUNDLER_WITHOUT development test
ENV BUNDLE_APP_CONFIG="/app/.bundle"

COPY . .

# RUN bundle config set --local deployment true
# RUN bundle config unset frozen
RUN bundle config build.nokogiri --use-system-libraries \
        --with-xml2-config=/usr/bin/xml2-config \
        --with-xslt-config=/usr/bin/xslt-config \
    && bundle config set without 'development:test:assets' \
    && bundle config set path 'vendor/bundle'

# BUNDLE
RUN bundle install

EXPOSE 3000
ENTRYPOINT ["sh", "./start-up.sh"]

VOLUME ["/app/log"]