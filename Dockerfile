
ARG VERSION
ARG BASE_IMAGE

FROM node:${VERSION}-${BASE_IMAGE}

# Install vue cli and Yarn
RUN apk update \
    && apk add --no-cache \
    yarn \
    bash \
    && yarn --version \
    && yarn global add @vue/cli

# DIR
WORKDIR /var/www/app