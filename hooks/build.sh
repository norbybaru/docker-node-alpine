#!/bin/bash

# norby/node:10
TAG="${REPO_NAME}:${VERSION}-${BASE_IMAGE}"

set -eux
docker build \
    --no-cache \
    -t "$TAG" \
    --build-arg BUILDKIT_INLINE_CACHE=1 \
    --build-arg VERSION=$VERSION \
    --build-arg BASE_IMAGE=$BASE_IMAGE \
    .

image_id=$(docker images $TAG --format "{{.ID}}")

docker images

for extra_tag in ${EXTRA_TAGS//;/$'\n'}
do
    echo $TAG
    echo $extra_tag
    docker tag $TAG "${REPO_NAME}:${extra_tag}"
done

docker run --rm --entrypoint node $TAG -v
docker run --rm --entrypoint npm $TAG -v
docker run --rm --entrypoint yarn $TAG -v