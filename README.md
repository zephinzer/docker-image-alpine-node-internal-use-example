# Minimal Node + Yarn Docker Image Internal Use Example
[![Build Status](https://travis-ci.org/zephinzer/docker-image-alpine-node-internal-use-example.svg?branch=public)](https://travis-ci.org/zephinzer/docker-image-alpine-node-internal-use-example)

An open-sourced, minimal, tested, extensible and customisable Node LTS + Yarn Docker image for building upon.

Check out the Docker Hub page at: https://hub.docker.com/r/zephinzer/alpine-node/

> This repository is an example repository with pipeline configurations to demonstrate usage in an internal environment pulling from GitHub.

> The main repository can be found at: https://github.com/zephinzer/docker-image-alpine-node.

> The main Travis CI pipeline can be found at: https://travis-ci.org/zephinzer/docker-image-alpine-node

> The Travis CI pipeline for this repository can be found at: https://travis-ci.org/zephinzer/docker-image-alpine-node-internal-use-example

## Changed Files
We have here a repository that is a mirror from the main repository that builds specific Argon (4.x), Boron (6.x) and Carbon (8.x) versions of Node. See the `./conf.d` folder for the implementation.

## Methodology

### Git for code management

1. Checkout the `public` branch in internal repository
2. Add source repository (in this case, it's https://github.com/zephinzer/docker-image-alpine-node.git) as a new remote
3. Pull from the source repository into the `public` branch
4. Push to the `public` branch in internal repository if the code was updated
5. Checkout a new `hybrid` branch in internal repository from the `public` branch
6. Remove indexing of files changed internally (in this example, we wish to override the `.travis.yml` and `README.md`)
7. Create an integration commit message so that anyone pulling from `master` branch in internal repository will understand changes have been made because they can't push
8. Switch to the `master` branch in internal repository
9. Check if there's a difference in commit hash between the `public` branch in internal repository and the `master` branch in the open source repository, if there is, merge changes with the `hybrid` branch and push to `master` in the internal repository.

A Travis CI version of the methodology has been implemented for this example repository and can be found in the `.travis.yml` file.

### Travis CI for application maintenance
To allow for full automation of open-source to internal repository integration, we set a Cron job in Travis CI to run this build every day. The Travis CI pipeline can be found at: https://travis-ci.org/zephinzer/docker-image-alpine-node-internal-use-example