FROM zephinzer/alpine-node:latest-boron
ENV EXTRA_DEPENDENCIES="python"
COPY . /app
RUN mkdir -p /var/cache/apk && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_DEPENDENCIES} && \
    yarn install && \
    apk del ${EXTRA_DEPENDENCIES}