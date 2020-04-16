# PlayTheWorld API

추후 여러 API로 분할되기 전의 기본이 될 API 서버입니다.

engines/model에 model만 분리하여 놓았습니다.

model이라는 rails engine은 모델부분만 다루는 gem으로 git submodule로 관리됩니다.

## 기록

1. Create Rails App

```bash
rails new PlayTheWorldAPI -T -C -B --api
```

2. Disabled action_mailer and active_model

3. Added middlewares [rack-attack](https://github.com/kickstarter/rack-attack) and [rack-cors](https://github.com/cyu/rack-cors)

4. Added [config](https://github.com/railsconfig/config) gem

5. Added [jwt](https://github.com/jwt/ruby-jwt) gem

...

## 서브모듈 관리

- git push시 (서브모듈도 함께)

```bash
git push --recurse-submodules=on-demand
```

- 서브모듈 업데이트(git pull과 같음)

```bash
git submodule update --remote --rebase
```

## 시작하기

Migration파일들을 가져온 후, migrate합니다.

```bash
rails railties:install:migrations db:drop db:create db:migrate
rails s -b 0.0.0.0
```

## 문서 보기

```bash
rails doc
```

- 이후, doc/index.html을 열기

## Install ruby 2.7.0 manually

```bash
curl -O 'https://raw.githubusercontent.com/rbenv/ruby-build/master/share/ruby-build/2.7.0'
rbenv install 2.7.0
rm 2.7.0
rbenv local 2.7.0
rbenv rehash
bundle
```

## Docker build

```bash
# export GIT_TOKEN={{your_git_personel_token}}
# docker build --build-arg GIT_TOKEN=$GIT_TOKEN --tag rails-docker .
# docker run -v $(pwd)/.docker/storage:/app/storage -v $(pwd)/.docker/log:/app/log rails-docker
docker-compose build --no-cache
docker-compose up -d
```
