#!/bin/bash
REVISION=$CIRCLE_SHA1
IFS="," read -ra DOCKER_TAGS \<< "$REVISION"

if [ $CIRCLE_BRANCH = 'development' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-dev-${SERVICE_NAME}:${tag}
  done
fi
if [ $CIRCLE_BRANCH = 'staging' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-stg-${SERVICE_NAME}:${tag}
  done
fi
if [ $CIRCLE_BRANCH = 'master' ]; then
  for tag in "${DOCKER_TAGS[@]}"; do
    docker push $AWS_ECR_ACCOUNT_URL/sgg-prd-${SERVICE_NAME}:${tag}
  done
fi