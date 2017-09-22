FROM zephinzer/alpine-node:latest-argon
RUN apk add python
ENTRYPOINT ["yarn", "install"]
COPY . /app