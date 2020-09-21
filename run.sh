#!/bin/bash

PS3='Select an environment:'
build_envs=("local" "dev" "test" "prod")
select env in "${build_envs[@]}"
do
  case $env in
    "local")
      invoker start invoker.ini
      break
      ;;
    "dev")
      docker-compose -f .configs/dev/docker-compose.yml up
      break
      ;;
    "test")
      echo "test"
      break
      ;;
    "prod")
      echo "prod"
      break
      ;;
    *) echo "invalid environment. $REPLY";;
  esac
done