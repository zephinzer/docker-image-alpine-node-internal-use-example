FROM zephinzer/alpine-node:latest-carbon
RUN apt add python
ENTRYPOINT ["yarn", "install"]
COPY . /app