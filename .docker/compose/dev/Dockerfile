# this is our first build stage, it will not persist in the final image
FROM alpine as intermediate

# install git
RUN apk add --no-cache --update \
    git
    # openssh

# add credentials on build
# ARG SSH_PRIVATE_KEY
# RUN mkdir /root/.ssh/
# RUN echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && chmod 600 /root/.ssh/id_rsa

# make sure your domain is accepted
# RUN touch /root/.ssh/known_hosts
# RUN ssh-keyscan github.com >> /root/.ssh/known_hosts
# RUN eval "$(ssh-agent)" && ssh-agent -s

ARG GIT_TOKEN
RUN git config --global url."https://${GIT_TOKEN}:@github.com/".insteadOf "https://github.com/"

# RUN git clone https://github.com/Play-The-World/kr.playtheworld.rails.api.base app
RUN git clone https://github.com/Play-The-World/kr.playtheworld.rails.api.base.git app

RUN cd app && git submodule init && git submodule update

FROM playtheworld/rails
# copy the repository form the previous image
COPY --from=intermediate /app /app

MAINTAINER Mechuri "mechuri@playthe.world"

WORKDIR /app

# ENV RAILS_ENV production
# ENV RACK_ENV production
ENV ENABLE_FILE_LOG true

# COPY .docker/compose/dev/database.yml ./config/

# Node 모듈 설치
# COPY package.json yarn.lock ./
# RUN yarn install --production
# certbot-auto certonly --manual --preferred-challenges=dns --email spb828@naver.com --server https://acme-v02.api.letsencrypt.org/directory --agree-tos --debug --no-bootstrap -d ericsnas.com
# Gem 모듈 설치
COPY Gemfile Gemfile.lock ./
RUN bundle install
# 레일즈 앱 전체 복사
# COPY . .

EXPOSE 3000
ENTRYPOINT ["sh", "./.docker/compose/dev/start-up.sh"]
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
# CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]

VOLUME ["/app/storage", "/app/log", "/app/config/database.yml"]

# RUN rm /root/.ssh/id_rsa