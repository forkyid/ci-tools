#!/bin/bash

if [ $CIRCLE_BRANCH = 'development' ]; then
  IFS="," read -ra DOCKER_TAGS \<<< "$CIRCLE_SHA1"
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-dev-${SERVICE_NAME}:${tag}
  done
fi
if [ $CIRCLE_BRANCH = 'staging' ]; then
  IFS="," read -ra DOCKER_TAGS \<<< "$CIRCLE_SHA1"
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-stg-${SERVICE_NAME}:${tag}
  done
fi
if [ $CIRCLE_BRANCH = 'master' ]; then
  IFS="," read -ra DOCKER_TAGS \<<< "$CIRCLE_SHA1"
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-prd-${SERVICE_NAME}:${tag}
  done
fi