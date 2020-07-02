FROM 947202957156.dkr.ecr.ap-northeast-2.amazonaws.com/playtheworld/rails:latest

LABEL maintainer="Mechuri mechuri@playthe.world"

WORKDIR /app

ENV ENABLE_FILE_LOG true

COPY . .
COPY .configs/production/database.yml config/database.yml
COPY .configs/production/prepare-db.sh .configs/production/wait-for-services.sh .configs/production/

RUN bundle install

EXPOSE 3000
ENTRYPOINT ["sh", "./start-up.sh"]

VOLUME ["/app/log", "/app/storage"]