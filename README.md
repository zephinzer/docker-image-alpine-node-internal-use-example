# Minimal Node + Yarn Docker Image
[![Build Status](https://travis-ci.org/zephinzer/docker-image-alpine-node.svg?branch=master)](https://travis-ci.org/zephinzer/docker-image-alpine-node)

A minimal, tested Node LTS + Yarn Docker image for building upon.

For tags, check out the Docker Hub page: https://hub.docker.com/r/zephinzer/alpine-node/

## What's Supported

By supported, it means tested/automated!

### Node
This Docker image supports only the LTS versions and the `latest` version. This means only `argon`, `boron` and `carbon` are supported as of now.

### Yarn
This Docker image installs the latest Yarn version at build time.

### Project Types
This image also runs tests on the Docker image to make sure that dependencies can be successfully installed. The following are project types with tests you can find in the `./test` folder.

#### React
Tests are found in `./test/react` and covers:

- latest-argon
- latest-boron
- latest-carbon

## Usage
Pull the image from DockerHub specifying the approrpriate version:

### Argon (v4.x)
For the latest use:

```dockerfile
FROM zephinzer/alpine-node:latest-argon
...
```

For other versions, use:

```dockerfile
FROM zephinzer/alpine-node:argon-x.y.z
...
```

Where `x.y.z` equals to a [tagged version in Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/)

### Boron (v6.x)
For the latest use:

```dockerfile
FROM zephinzer/alpine-node:latest-boron
...
```

For other versions, use:

```dockerfile
FROM zephinzer/alpine-node:boron-x.y.z
...
```

Where `x.y.z` equals to a [tagged version in Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/)

### Carbon (v8.x)
For the latest use:

```dockerfile
FROM zephinzer/alpine-node:latest-carbon
...
```

For other versions, use:

```dockerfile
FROM zephinzer/alpine-node:carbon-x.y.z
...
```

Where `x.y.z` equals to a [tagged version in Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/)

## Kudos
This repository was inspired by https://github.com/mhart/alpine-node.
