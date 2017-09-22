FROM zephinzer/alpine-node:latest-carbon
ENV EXTRA_DEPENDENCIES="python"
RUN apk udate && \
    apk upgrade && \
    apk add $EXTRA_DEPENDENCIES
ENTRYPOINT ["yarn", "install"]
COPY . /app