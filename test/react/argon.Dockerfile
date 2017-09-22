FROM zephinzer/alpine-node:latest-argon
ENV EXTRA_DEPENDENCIES="python"
RUN apk update && \
    apk upgrade && \
    apk add $EXTRA_DEPENDENCIES
ENTRYPOINT ["yarn", "install"]
COPY . /app