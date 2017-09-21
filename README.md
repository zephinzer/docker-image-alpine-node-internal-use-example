# Minimal Node + Yarn Docker Image
[![Build Status](https://travis-ci.org/zephinzer/docker-image-alpine-node.svg?branch=master)](https://travis-ci.org/zephinzer/docker-image-alpine-node)

A minimal, tested Node LTS + Yarn Docker image for building upon.

For tags, check out the Docker Hub page: https://hub.docker.com/r/zephinzer/alpine-node/

## What's Supported

### Node
This Docker image supports only the LTS versions and the `latest` version. This means only `argon`, `boron` and `carbon` are supported as of now.

### Yarn
This Docker image installs the latest Yarn version at build time.

### Application Layer Frameworks/Libraries
This image also runs tests on the Docker image to make sure that dependencies can be successfully installed. The following are project types with tests you can find in the `./test` folder.

#### React
Tests are found in `./test/react` and covers:

- latest-argon
- latest-boron
- latest-carbon

## Usage
Pull the image from DockerHub specifying the approrpriate version:

### In General
For a specific Node version, use:

```dockerfile
FROM zephinzer/alpine-node:vx.y.z
...
```

For a specific Node and Yarn version, use:

```dockerfile
FROM zephinzer/alpine-node:node-vX.Y.Z_yarn-vA.B.C
...
```

Where `X.Y.Z` is the semver version of Node and `A.B.C` is the semver version of Yarn. Check the [Tags in Docker Hub Registry](https://hub.docker.com/r/zephinzer/alpine-node/tags/) to see what versions are available.

Or just grab the latest build with:

```dockerfile
FROM zephinzer/alpine-node:latest
...
```

### For Argon (v4.x)
For the latest version of `argon`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-argon
...
```

### Boron (v6.x)
For the latest version of `boron`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-boron
...
```

### Carbon (v8.x)
For the latest version of `carbon`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-carbon
...
```

## Kudos
This repository was inspired by https://github.com/mhart/alpine-node.
