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

### As Image
Pull the image from DockerHub specifying the approrpriate version:

#### In General
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

#### With Argon (v4.x)
For the latest version of `argon`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-argon
...
```

#### With Boron (v6.x)
For the latest version of `boron`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-boron
...
```

#### With Carbon (v8.x)
For the latest version of `carbon`, use:

```dockerfile
FROM zephinzer/alpine-node:latest-carbon
...
```

### From Repository Release
Every successful build/test run by Travis results in a release by tagging the commit with a semver version. You may choose to download the project from the releases page but should you do that, you will need to run the following command to generate the correct `Dockerfile` before you can build it. Run the following commands:

```bash
# ./scripts/use argon
# ./scripts/use boron
# ./scripts/use carbon
```

These will create `Dockerfile`s for `argon` (Node 4.x LTS), `boron` (Node 6.x LTS) and `carbon` (Node 8.x) respectively. You can then build it via:

```bash
# docker build .
```

## Contribution/Maintenance

> WIP

## Kudos
This repository was inspired by https://github.com/mhart/alpine-node.
