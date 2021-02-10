#!/bin/bash

STAGE=""
API=""

case $CIRCLE_BRANCH in
development)
  STAGE="dev"
  API=$API_DEV_RELEASES_STATUS
  break
  ;;
staging)
  STAGE="stg"
  API=$API_STG_RELEASES_STATUS
  break
  ;;
production)
  STAGE="prd"
  API=$API_PRD_RELEASES_STATUS
  break
  ;;
esac

curl --location --request PATCH $API --header "Authorization: Basic $BASIC_AUTH" --header 'Content-Type: application/json' --data-raw "{\"workflow_name\": \"$WORKFLOW_NAME\", \"workflow_id\": \"$CIRCLE_WORKFLOW_ID\", \"job_id\": \"$CIRCLE_WORKFLOW_JOB_ID\", \"stage\": \"$STAGE\", \"project_name\": \"$SERVICE_NAME\", \"release_status\": \"success\"}"
