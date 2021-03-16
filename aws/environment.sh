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
  aws s3 cp "s3://sgg-${STAGE}-environment/${SERVICE_NAME}/${APP_VERSION}/.env" .
fi