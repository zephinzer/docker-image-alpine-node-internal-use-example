FROM zephinzer/alpine-node:latest-carbon
ENV EXTRA_DEPENDENCIES="python make g++"
COPY . /app
RUN mkdir -p /var/cache/apk && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_DEPENDENCIES} && \
    yarn install && \
    yarn cache clean && \
    apk del ${EXTRA_DEPENDENCIES}
ENTRYPOINT ["echo", "'All is well'"]