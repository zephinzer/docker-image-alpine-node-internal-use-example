FROM zephinzer/alpine-node:latest-boron
RUN apt add python
ENTRYPOINT ["yarn", "install"]
COPY . /app