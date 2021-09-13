FROM 947202957156.dkr.ecr.ap-northeast-2.amazonaws.com/playtheworld/rails:latest

LABEL maintainer="Mechuri mechuri@playthe.world"

WORKDIR /app

ENV ENABLE_FILE_LOG true
# ENV BUNDLER_WITHOUT development test

COPY . .

RUN bundle config set --local deployment true
RUN bundle config unset frozen
RUN bundle install

EXPOSE 3000
ENTRYPOINT ["sh", "./start-up.sh"]

VOLUME ["/app/log"]