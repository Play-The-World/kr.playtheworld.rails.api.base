#!/bin/bash

export FONT_BOLD=$(tput bold)
export FONT_NORMAL=$(tput sgr0)

# GET BUILD ENVIRONMENT
echo "Select an environment (${FONT_BOLD}dev${FONT_NORMAL} | test | prod):"
read BUILD_ENV

export BUILD_ENV="$(echo "$BUILD_ENV" | tr -d '[:space:]')"

# SET DEFAULT VALUES
if [ "$BUILD_ENV" = "" ]; then
  export BUILD_ENV="dev"
fi

if [ "$BUILD_ENV" = "dev" ]; then
  docker-compose -f .configs/dev/docker-compose.yml up
elif [ "$BUILD_ENV" = "test" ]; then
  echo "test"
elif [ "$BUILD_ENV" = "prod" ]; then
  echo "prod"
else
  echo "WRONG ENV '$BUILD_ENV'"
fi

# UNSET ENVIRONMENT VALUES
unset FONT_BOLD
unset FONT_NORMAL
unset BUILD_ENV