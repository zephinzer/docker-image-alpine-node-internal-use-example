FROM zephinzer/alpine-node:__IMAGE_TAG__
ENV EXTRA_APK_DEPENDENCIES=__EXTRA_APK_DEPENDENCIES__
WORKDIR /app
RUN apk update && apk upgrade && \
    apk add --no-cache ${EXTRA_APK_DEPENDENCIES} && \
    yarn install && yarn cache clean && \
    apk del ${EXTRA_APK_DEPENDENCIES} && \
    rm -rf /usr/share/man/* /var/cache/apk/*
COPY . /app
ENTRYPOINT ["./test-entry"]