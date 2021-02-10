#!/bin/bash
set -u

docker_tag_args=""
IFS="," read -ra DOCKER_TAGS \<<< "$CIRCLE_SHA1"
if [ $CIRCLE_BRANCH = 'development' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker_tag_args="$docker_tag_args -t $AWS_ECR_ACCOUNT_URL/sgg-dev-${SERVICE_NAME}:$tag"
  done
  docker build -f docker/Dockerfile-dev $docker_tag_args .
fi
if [ $CIRCLE_BRANCH = 'staging' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker_tag_args="$docker_tag_args -t $AWS_ECR_ACCOUNT_URL/sgg-stg-${SERVICE_NAME}:$tag"
  done
  docker build -f docker/Dockerfile-stg $docker_tag_args .
fi
if [ $CIRCLE_BRANCH = 'master' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker_tag_args="$docker_tag_args -t $AWS_ECR_ACCOUNT_URL/sgg-prd-${SERVICE_NAME}:$tag"
  done
  docker build -f docker/Dockerfile-prd $docker_tag_args .
fi