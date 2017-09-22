FROM zephinzer/alpine-node:latest-argon
ENV EXTRA_DEPENDENCIES="python make g++"
COPY . /app
RUN mkdir -p /var/cache/apk && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_DEPENDENCIES} && \
    yarn install && \
    apk del ${EXTRA_DEPENDENCIES}
ENTRYPOINT ["echo", "'All is well'"]