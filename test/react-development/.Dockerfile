FROM zephinzer/alpine-node:__IMAGE_TAG__
ENV EXTRA_APK_DEPENDENCIES=__EXTRA_APK_DEPENDENCIES__
WORKDIR /app/.test
COPY . /app/.test
RUN mkdir -p /var/cache/apk && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_APK_DEPENDENCIES} && \
    yarn install && \
    yarn cache clean && \
    apk del ${EXTRA_APK_DEPENDENCIES} && \
    rm -rf /var/cache/apk/*
ENTRYPOINT ["npm", "run", "test"]