FROM zephinzer/alpine-node:latest-carbon
ENTRYPOINT ["yarn", "install"]
COPY . /app