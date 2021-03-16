#!/bin/bash

STAGE=""
case $CIRCLE_BRANCH in
development)
  STAGE="dev"
  break
  ;;
staging)
  STAGE="stg"
  break
  ;;
production)
  STAGE="prd"
  break
  ;;
esac

if [ "$CIRCLE_BRANCH" = "development" ] || [ "$CIRCLE_BRANCH" = "staging" ] || [ "$CIRCLE_BRANCH" = "master" ]
then
  aws ecr describe-repositories --profile default --region $AWS_DEFAULT_REGION --repository-names sgg-${STAGE}-${SERVICE_NAME} > /dev/null 2>&1 || \
  aws ecr create-repository --profile default --region $AWS_DEFAULT_REGION --repository-name sgg-${STAGE}-${SERVICE_NAME}
fi