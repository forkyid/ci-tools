# #!/bin/bash

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

REVISION=$CIRCLE_SHA1
REPOSITORY="${AWS_ECR_ACCOUNT_URL}/sgg-${STAGE}-${SERVICE_NAME}"
DOCKER_TAG=""

IFS="," read -ra DOCKER_TAGS <<< "$REVISION"
for tag in "${DOCKER_TAGS[@]}"; do
  DOCKER_TAG=$tag
done

# Build docker image
docker build -f docker/Dockerfile-${STAGE} -t ${REPOSITORY}:${DOCKER_TAG} .

# Push image to Amazon ECR
docker push ${REPOSITORY}:${DOCKER_TAG}
