FROM zephinzer/alpine-node:latest-carbon
RUN apk add python
ENTRYPOINT ["yarn", "install"]
COPY . /app