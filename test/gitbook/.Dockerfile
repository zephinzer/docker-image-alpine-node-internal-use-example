FROM zephinzer/alpine-node:__IMAGE_TAG__
ENV EXTRA_APK_DEPENDENCIES=__EXTRA_APK_DEPENDENCIES__
WORKDIR /app
RUN if [ "${EXTRA_APK_DEPENDENCIES}" != "" ]; then \
      apk update && \
      apk upgrade && \
      apk add --no-cache ${EXTRA_APK_DEPENDENCIES}; \
    fi && \
    npm install -g gitbook-cli && \
    gitbook ls-remote | sed -e "s|, |  |g" | xargs -n1 echo | sort | egrep "^[0-9]\.[0-9]\.[0-9]$" > /tmp/versions && \
    gitbook fetch $(cat /tmp/versions | tail -n 1) && \
    if [ "${EXTRA_APK_DEPENDENCIES}" != "" ]; then apk del ${EXTRA_APK_DEPENDENCIES}; fi && \
    rm -rf /usr/share/man/* /var/cache/apk/* /tmp/*
COPY . /app
ENTRYPOINT ["gitbook", "build"]