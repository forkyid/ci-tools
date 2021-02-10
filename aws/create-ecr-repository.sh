#!/bin/bash

if [ $CIRCLE_BRANCH = 'development' ]; then
  aws ecr describe-repositories --profile default --region $AWS_DEFAULT_REGION --repository-names sgg-dev-${SERVICE_NAME} > /dev/null 2>&1 || \
  aws ecr create-repository --profile default --region $AWS_DEFAULT_REGION --repository-name sgg-dev-${SERVICE_NAME}
fi
if [ $CIRCLE_BRANCH = 'staging' ]; then
  aws ecr describe-repositories --profile default --region $AWS_DEFAULT_REGION --repository-names sgg-stg-${SERVICE_NAME} > /dev/null 2>&1 || \
  aws ecr create-repository --profile default --region $AWS_DEFAULT_REGION --repository-name sgg-stg-${SERVICE_NAME}
fi
if [ $CIRCLE_BRANCH = 'master' ]; then
  aws ecr describe-repositories --profile default --region $AWS_DEFAULT_REGION --repository-names sgg-prd-${SERVICE_NAME} > /dev/null 2>&1 || \
  aws ecr create-repository --profile default --region $AWS_DEFAULT_REGION --repository-name sgg-prd-${SERVICE_NAME}
fi