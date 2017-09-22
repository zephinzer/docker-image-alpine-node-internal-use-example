FROM zephinzer/alpine-node:latest-argon
RUN apt add python
ENTRYPOINT ["yarn", "install"]
COPY . /app