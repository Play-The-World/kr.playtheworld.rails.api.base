#!/bin/bash

# AWS LOGIN
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 947202957156.dkr.ecr.ap-northeast-2.amazonaws.com/playtheworld/nginx

# GET BUILD ENVIRONMENT
echo Insert an environment\(dev is default\):
read BUILD_ENV

# GET TAG NAME
echo Insert a docker tag\(latest is default\):
read IMAGE_TAG

# GET USER ANSWER
echo Do you want to push? \(y/N\):
read PUSH_FLAG

export BUILD_ENV="$(echo "$BUILD_ENV" | tr -d '[:space:]')"
export IMAGE_TAG="$(echo "$IMAGE_TAG" | tr -d '[:space:]')"
export IMAGE_NAME="playtheworld/test-api"
export REPOSITORY_URI="947202957156.dkr.ecr.ap-northeast-2.amazonaws.com"

# SET DEFAULT VALUES
if [ "$BUILD_ENV" = "" ]; then
  export BUILD_ENV="dev"
fi
if [ "$IMAGE_TAG" = "" ]; then
  export IMAGE_TAG="latest"
fi

# BUILD
docker build -f .configs/"$BUILD_ENV"/Dockerfile -t "$IMAGE_NAME":"$IMAGE_TAG" .
docker tag "$IMAGE_NAME":"$IMAGE_TAG" "$REPOSITORY_URI"/"$IMAGE_NAME":"$IMAGE_TAG"

if [ "$PUSH_FLAG" = "y" ]; then
  # PUSH
  docker push "$REPOSITORY_URI"/"$IMAGE_NAME":"$IMAGE_TAG"
fi

# UNSET ENVIRONMENT VALUES
unset BUILD_ENV
unset IMAGE_TAG
unset IMAGE_NAME
unset REPOSITORY_URI
unset PUSH_FLAG