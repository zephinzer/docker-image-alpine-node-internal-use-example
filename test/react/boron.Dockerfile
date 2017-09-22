FROM zephinzer/alpine-node:latest-boron
RUN apk add python
ENTRYPOINT ["yarn", "install"]
COPY . /app