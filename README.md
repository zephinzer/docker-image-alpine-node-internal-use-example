# Alpine:Node Docker Image
[![Build Status](https://travis-ci.org/zephinzer/docker-image-alpine-node.svg?branch=master)](https://travis-ci.org/zephinzer/docker-image-alpine-node)

An open-sourced, minimal, tested, extensible, customisable and self-updating Node image.

This image is a base image with Alpine Linux, Node and Yarn that has been designed for open-source with options to migrate over to a closed-source internal environment.

## TL;DR : Use It

Use this in a Dockerfile (with `__TAG_ID__` set to a [Tag as listed on Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/))

```dockerfile
FROM zephinzer/alpine-node:__TAG_ID__
WORKDIR /app
COPY . /app
ENTRYPOINT ["./docker-entrypoint.sh"]
```

Or use this in a Docker-Compose (with `__TAG_ID__` set to a [Tag as listed on Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/))

```yaml
version: "3"
services:
  alpine_node:
    image: zephinzer/alpine-node:__TAG_ID__
    working_dir: /app
    entrypoint: "yarn --version"
    volumes:
      - ./:/app
  ...
```

To customise a build, see the [Customising the Build section in Usage](#customising-the-build) for information.

### Relevant Links
The Docker Hub page can be found at: https://hub.docker.com/r/zephinzer/alpine-node/

The Travis pipeline can be found at: https://travis-ci.org/zephinzer/docker-image-alpine-node

The example project for internal usage can be found at: https://github.com/zephinzer/docker-image-alpine-node-internal-use-example

The Travis pipeline for internal usage can be found at: https://travis-ci.org/zephinzer/docker-image-alpine-node-internal-use-example

## Guiding Principles
Yet another `alpine-node` repository? Of course not. Here's what's different.

### Open Sourced
This image is designed to be open-sourced, for close-sourced usage in internal repositories.

### Minimal
This image is designed to be minimal, and this is accomplished through using Linux Alpine and building our own Node with custom parameters. Yarn is also installed because it reduces eventual container size.

Why minimal? Small sizes allow for easy logsitics during deployment and lean images reduce the risk of vulnerabilities.

### Tested
This image is tested and proven to work with documented builds. See the `./test` directory to see the types of projects this base image can work with. Each sub-directory in `./test` includes a `.Dockerfile` which you can use as a template to pull from the desired tag, and a `.extra-apk-dependencies` which indicate what additional packages need to be installed for the build. The `package.json` specifies packages which will be included in the build, so if your desired package is there, it will work when you use this base image! See [Application Layer Frameworks/Libraries](#application-layer-frameworkslibraries) for a listing of NPM dependencies that will work with this image.

### Extensible
Unlike other images, this image was designed so that you could run `apk add [EXTRA_APK_DEPENDENCIES]` from your own Dockerfile should things fail to build/run because of missing base dependencies. This image was also designed to be a base image for multiple other application images which we use internally, and will be updated and maintained to extend while maintaining backward compatibitlity.

### Customisable
Being designed for open-source for close-sourced usage, this image includes lots of templating which can be configured according to your needs. This is achieved through the `./conf.d` folder where you can specify the following variables as filenames with their values being the file's content to use when building this image from it's Dockerfile:

- `BASE_IMAGE_SOURCE`: (defaults to `iron/base`)
- `BASE_IMAGE_TAG`: (defaults to `3.4`)
- `YARN_VERSION`: (defaults to `v1.0.2`)
- `ARGON_VERSION`: (defaults to `v4.8.4`)
- `BORON_VERSION`: (defaults to `v6.11.3`)
- `CARBON_VERSION`: (defaults to `v8.5.0`)

See the [Customising the Build section in Usage](#customising-the-build) for information on how to customise a build.

### Self-Updating
Other images require constant maintenance. We didn't want this repository to depend on us for updates, so we implemented methods to grab the latest versions of Node and Yarn to include in our daily build. See our build scripts in the `./scripts` for details. We currently grab the latest:

- Node Argon (4.x)
- Node Boron (6.x)
- Node Carbon (8.x)
- Yarn

## So... What's Supported

### Node
This Docker image supports only the LTS versions and the `latest` version. This means only `argon`, `boron` and `carbon` are supported as of now. This will be updated as future versions of Node are released.

### Yarn
This Docker image installs the latest Yarn version at build time. We recommended the usage of Yarn based on the experiment documented here: https://medium.com/@iamnayr/a-multi-part-analysis-of-node-docker-image-sizes-using-yarn-vs-traditional-npm-2c20f034c08f.

### Application Layer Frameworks/Libraries
This image also runs tests on the Docker image to make sure that dependencies can be successfully installed. The following are project types with tests you can find in the `./test` folder.

The tests **DO NOT GUARANTEE** that application-level logic/build works. We however **DO GUARANTEE** that the dependencies specified in the accompanying `./test/<TEST_CASE_ID>/package.json` can be installed with the Dockerfile `RUN` step in `./test/<TEST_CASE_ID>/.Dockerfile` with the extra required dependencies specified in `./test/<TEST_CASE_ID>/.extra-apk-dependencies`.

#### Node [Development]
- [BookShelf](https://github.com/bookshelf/bookshelf) : ORM library
- [BusBoy](https://github.com/mscdex/busboy) : Form data parser middleware
- [Chai](https://github.com/chaijs/chai) : Assertion library
- [Compression](https://github.com/expressjs/compression) : GZIP middleware
- [CORS](https://github.com/expressjs/cors) : CORS helper library
- [EJS](https://github.com/tj/ejs) : Templating engine
- [ESLint](https://github.com/eslint/eslint) : Static code analysis
- [Express](https://github.com/expressjs/express) : Framework
- [Istanbul](https://github.com/gotwarlost/istanbul) : Code coverage generator
- [Jade](https://www.npmjs.com/package/jade) : Templating engine
- [Jasmine](https://github.com/jasmine/jasmine) : Test framework
- [Helmet](https://github.com/helmetjs/helmet) : HTTP header protection
- [Knex](https://github.com/tgriesser/knex) : Query builder
- [Mocha](https://github.com/mochajs/mocha) : Test framework + runner
- [Mongoose](https://github.com/Automattic/mongoose) : MongoDB client
- [Morgan](https://github.com/expressjs/morgan) : Request logger
- [MySQL](https://github.com/mysqljs/mysql) : MySQL client
- [MySQL2](https://github.com/sidorares/node-mysql2) : MySQL client
- [PG](https://github.com/brianc/node-postgres) : PostgreSQL client
- [Redis](https://github.com/NodeRedis/node_redis) : Redis client
- [Rewire](https://github.com/jhnns/rewire) : Monkey-patching library
- [Sinon](https://github.com/sinonjs/sinon) : Object mocking library
- [Sequelize](https://github.com/sequelize/sequelize) : ORM library
- [Supertest](https://github.com/visionmedia/supertest) : Request mocking library
- [SQLite3](https://github.com/mapbox/node-sqlite3) : SQLite library
- [Winston](https://github.com/winstonjs/winston) : Process logger

#### React [Development]

- [Babel](https://github.com/babel/babel) : ECMAScript transpiler
- [Chai](https://github.com/chaijs/chai) : Assertion library
- [Enzyme](https://github.com/airbnb/enzyme) : React component test rendering library
- [ESLint](https://github.com/eslint/eslint) : Static code analysis
- [Jasmine](https://github.com/jasmine/jasmine) : Test framework
- [Jest](https://github.com/facebook/jest) : Test framework + runner
- [Karma](https://github.com/karma-runner/karma) : Test runner
- [Mocha](https://github.com/mochajs/mocha) : Test framework + runner
- [NSP](https://github.com/nodesecurity/nsp) : Node modules vulnerability scanner
- [PhantomJS](https://github.com/Medium/phantomjs) (*via `phantomjs-prebuilt`*) : Headless browser
- [React Hot Loader](https://github.com/gaearon/react-hot-loader) : Hot reloading middelware
- [Rewire](https://github.com/speedskater/babel-plugin-rewire) (*via `babel-plugin-rewire`*) : Monkey-patching library
- [SASS](https://github.com/sass/node-sass) (*via `node-sass`*) : SASS functionality provider
- [Should](https://github.com/shouldjs/should.js) : Assertion library
- [Sinon](https://github.com/sinonjs/sinon) : Object mocking library
- [Webpack](https://github.com/webpack/webpack) : JavaScript bundler
- [Webpack Dev Middleware](https://github.com/webpack/webpack-dev-middleware) : Development middleware for React
- [Webpack Hot Middleware](https://github.com/glenjamin/webpack-hot-middleware) : Hot-reloading middleware for React

Tests are found in `./test/react-development`. If you wish to add on to this list, please fork this repo, add the packages you need tested and submit a merge request.

## Usage

### Choosing the Tag

Everytime we publish a new image tag, we include 3 versions:

- `NODE_VERSION`
- `node-NODE_VERSION_yarn-YARN_VERSION`
- `latest-NODE_CODENAME`

The highest available version is also published with `latest`.

The `NODE_VERSION` and `latest-NODE_CODENAME` tags will always contain the latest Yarn as it is overwritten as new Node/Yarn versions come out.

Should you need control over the Node and Yarn version, use the `node-NODE_VERSION_yarn-YARN_VERSION` tag type as that will ensure the version of both Node and Yarn.

### As a Base Image via Dockerfile

```dockerfile
FROM zephinzer/alpine-node:__TAG_ID__
# install system dependencies required for build and remove cached stuff
RUN mkdir -p /var/cache/apk && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${EXTRA_APK_DEPENDENCIES} && \
    yarn install && \
    yarn cache clean && \
    apk del ${EXTRA_APK_DEPENDENCIES} && \
    rm -rf /var/cache/apk/*
COPY . /app
ENTRYPOINT ["./docker-entrypoint.sh"]
```

The `__TAG_ID__` can be found from the [Tags section in Docker Hub](https://hub.docker.com/r/zephinzer/alpine-node/tags/).

You can find documented `EXTRA_APK_DEPENDENCIES` within our tests which will indicate what other APK dependencies you will need in order to build your NPM dependencies.

### As a Container Image via Docker-Compose

```dockerfile
version: "3"
services:
  app:
    image: zephinzer/alpine-node:latest
    working_dir: /app
    entrypoint: "/app/docker-entrypoint.sh"
    volumes:
      - ./:/app
    ...
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

### Customising the Build
For example, if you wanted to use `centos/centos:7` as your base image to build Node Carbon v8.4.0 and include Yarn v1.0.0,

- Clone this repository or download a release from the [Releases Section](https://github.com/zephinzer/docker-image-alpine-node/releases)
    - `git clone git@github.com:zephinzer/docker-image-alpine-node.git`
- Add the relevant files to `./conf.d` to configure the build
    - `printf "centos/centos" > ./conf.d/BASE_IMAGE_SOURCE`
    - `printf "7" > ./conf.d/BASE_IMAGE_TAG`
    - `printf "v8.4.0" > ./conf.d/CARBON_VERSION`
    - `printf "v1.0.0" > ./conf.d/YARN_VERSION`
- Create the build files:
    - `./scripts/build/setup`
- Build the image:
    - `docker build -f carbon.Dockerfile -t my_carbon .`
- Remove the build files:
    - `./scripts/build/teardown`
- Find your image:
    - `docker images | grep my_carbon`

This may be unnecessarily complicated, but we use this process so that we can open-source our logic, but use internally scanned and tested base images within our own products.

See [Internal Use Example project](https://github.com/zephinzer/docker-image-alpine-node-internal-use-example) for an example of maintaining an internal repository.

## Contribution/Maintenance/Release Cycle

### Contribution of Tests
Should you wish to add a test for a new package/to update currently listed packages in the `./package.json`, fork this repo, add your relevant tests and submit a merge request.

### Areas for Maintenance
Currently, automated retrieval and building of MINOR and PATCH versions are supported. However, when the Node Foundation names a new LTS version, this will have to be added manually. The following files should be updated:

- `./test/.tags-to-test` : add a new line `latest-<LTS_CODENAME>`.
- `./.travis.yml`
  - add a new job per `test` stage that uses the relevant codename as specified in `.tags-to-test`.
  - add a new job per `build` stage that uses the relevant codename
- `./scripts/build/setup` : search for `[[MAINTENANCE]]` tags and add the new codename. Current codenames begin each section with `## <codename> (Y.x)` where Y is the major version number and `<codename>` is one of `argon`, `boron` and `carbon`.

The scripts used to grab the latest version of Node and Yarn can also be found in `./scripts/build/setup` and may break if Node/Yarn decides to change how they list their versions and releases. Fix it by modifying the version retrieval logic.

### Release Cycle
The Travis CI script is set to run **every day at least once**, ensuring that latest versions will always be built. Image versions available are from time of first publication (24th September 2017) and includes all versions **after** the following:

- Node Argon v4.8.4
- Node Boron v6.11.3
- Node Carbon v8.5.0
- Yarn 1.0.2

### Release Versioning
This repository contains a [semver](http://semver.org/) versioning system where every successful CI run by Travis increases the PATCH version. There is no need to do anything. Breaking changes will be handled by the maintainers who will update the MAJOR and MINOR versions. To see where minor/major releases were made, search for commits with `[minor version bump]` and `[major version bump]` for minor and major versions respectively.

### Force Rebuilding
Occassionally because of security vulnerabilities, it is necessary to rebuild previous containers because the build methodology is broken. For such cases, include a `[force build]` string inside the commit message to force the rebuild of the latest versions.

## Cheers
If you feel this is awesome, give it a star to show your support!
