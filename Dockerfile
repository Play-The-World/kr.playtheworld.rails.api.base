FROM 947202957156.dkr.ecr.ap-northeast-2.amazonaws.com/playtheworld/rails:latest

MAINTAINER Mechuri "mechuri@playthe.world"

WORKDIR /app

# ENV RAILS_ENV production
# ENV RACK_ENV production
ENV ENABLE_FILE_LOG true

# COPY .docker/compose/dev/database.yml ./config/

# Gem 모듈 설치
# COPY Gemfile Gemfile.lock ./
COPY . .

RUN bundle install

EXPOSE 3000
# ENTRYPOINT ["sh", "./.docker/compose/dev/start-up.sh"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

VOLUME ["/app/log"]