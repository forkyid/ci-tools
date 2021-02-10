#!/bin/bash

if [ $CIRCLE_BRANCH = 'development' ]; then
  curl --location --request PATCH $API_DEV_RELEASES_STATUS --header "Authorization: Basic $BASIC_AUTH" --header 'Content-Type: application/json' --data-raw "{\"workflow_name\": \"$WORKFLOW_NAME\", \"workflow_id\": \"$CIRCLE_WORKFLOW_ID\", \"job_id\": \"$CIRCLE_WORKFLOW_JOB_ID\", \"stage\": \"development\", \"project_name\": \"$SERVICE_NAME\", \"release_status\": \"failed\"}"
fi
if [ $CIRCLE_BRANCH = 'staging' ]; then
  curl --location --request PATCH $API_STG_RELEASES_STATUS --header "Authorization: Basic $BASIC_AUTH" --header 'Content-Type: application/json' --data-raw "{\"workflow_name\": \"$WORKFLOW_NAME\", \"workflow_id\": \"$CIRCLE_WORKFLOW_ID\", \"job_id\": \"$CIRCLE_WORKFLOW_JOB_ID\", \"stage\": \"staging\", \"project_name\": \"$SERVICE_NAME\", \"release_status\": \"failed\"}"
fi
if [ $CIRCLE_BRANCH = 'master' ]; then
  curl --location --request PATCH $API_PRD_RELEASES_STATUS --header "Authorization: Basic $BASIC_AUTH" --header 'Content-Type: application/json' --data-raw "{\"workflow_name\": \"$WORKFLOW_NAME\", \"workflow_id\": \"$CIRCLE_WORKFLOW_ID\", \"job_id\": \"$CIRCLE_WORKFLOW_JOB_ID\", \"stage\": \"master\", \"project_name\": \"$SERVICE_NAME\", \"release_status\": \"failed\"}"
fi