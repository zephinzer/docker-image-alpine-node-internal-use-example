FROM zephinzer/alpine-node:latest-boron
ENTRYPOINT ["yarn", "install"]
COPY . /app