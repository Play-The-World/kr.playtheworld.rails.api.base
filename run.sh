#!/bin/bash

docker run -p 3000:3000 \
  -v /Users/eric/workspace/PlayTheWorldAPI.docker/log:/app/log \
  -v /Users/eric/workspace/PlayTheWorldAPI.docker/storage:/app/storage \
  playtheworld/test-api