#!/bin/bash
# 참조
# https://danthetech.netlify.com/Backend/installing-private-repository-in-github-into-docker-container
export SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)"

# echo Insert a docker tag\(latest is default\):
# read Tag
# export Trimmed_tag="$(echo "$Tag" | tr -d '[:space:]')"
export Trimmed_tag="rails-docker"

export Docker_image_name="rails_test"
if [ "$Trimmed_tag" = "" ]; then
  docker build --build-arg SSH_PRIVATE_KEY -t "$Docker_image_name":latest .
  # docker push "$Docker_image_name":latest
else
  docker build --no-cache --build-arg SSH_PRIVATE_KEY -t "$Docker_image_name":"$Trimmed_tag" .
  # docker push "$Docker_image_name":"$Trimmed_tag"
fi

unset SSH_PRIVATE_KEY
unset Docker_image_name
unset Trimmed_tag