FROM zephinzer/alpine-node:latest-carbon
ENV EXTRA_DEPENDENCIES="python"
COPY . /app
RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_DEPENDENCIES} && \
    yarn install && \
    apk del ${EXTRA_DEPENDENCIES}