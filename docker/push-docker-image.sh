# #!/bin/bash
set -u

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
DOCKER_TAG_ARGS=""
REPOSITORY="${AWS_ECR_ACCOUNT_URL}/sgg-${STAGE}-${SERVICE_NAME}"

IFS="," read -ra DOCKER_TAGS <<< "$REVISION"
for tag in "${DOCKER_TAGS[@]}"; do
  DOCKER_TAG_ARGS="$DOCKER_TAG_ARGS -t $REPOSITORY:$tag"
done

# build image
docker build -f docker/Dockerfile-${STAGE} $DOCKER_TAG_ARGS .

for tag in "${DOCKER_TAGS[@]}"; do
  docker push ${REPOSITORY}:${tag}
done

