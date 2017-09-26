# Minimal Node + Yarn Docker Image
[![Build Status](https://travis-ci.org/zephinzer/docker-image-alpine-node.svg?branch=master)](https://travis-ci.org/zephinzer/docker-image-alpine-node)

An open-sourced, minimal, tested, extensible and customisable Node LTS + Yarn Docker image for building upon.

Check out the Docker Hub page at: https://hub.docker.com/r/zephinzer/alpine-node/

## Guiding Principles
Yet another `alpine-node` repository? Of course not. Here's what's different.

### Open Sourced
This image is designed to be open-sourced, for close-sourced usage in internal repositories.

### Minimal
This image is designed to be minimal, and this is accomplished through using Linux Alpine and building our own Node with custom parameters. Yarn is also installed because it reduces eventual container size.

Why minimal? Small sizes allow for easy logsitics during deployment and lean images reduce the risk of vulnerabilities.

### Tested
This image is tested and proven to work with documented builds. See the `./test` directory to see the types of projects this base image can work with. Each sub-directory in `./test` includes a `.Dockerfile` which you can use as a template to pull from the desired tag, and a `.extra-apk-dependencies` which indicate what additional packages need to be installed for the build. The `package.json` specifies packages which will be included in the build, so if your desired package is there, it will work when you use this base image!

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

For example, if you wanted to use `centos/centos:7` as your base image to build Node Carbon v8.4.0 and include Yarn v1.0.0,

- Clone this repository
> `git clone git@github.com:zephinzer/docker-image-alpine-node.git`
- Add a file named `BASE_IMAGE_SOURCE` in `./conf.d` with `centos/centos` as it's content
> `printf "centos/centos" > ./conf.d/BASE_IMAGE_SOURCE`
- Add a file named `BASE_IMAGE_TAG` in `./conf.d` with `7` as it's content
> `printf "7" > ./conf.d/BASE_IMAGE_TAG`
- Add a file named `CARBON_VERSION` in `./conf.d` with `v8.4.0` as it's content
> `printf "v8.4.0" > ./conf.d/CARBON_VERSION`
- Add a file named `YARN_VERSION` in `./conf.d` with `v1.0.0` as it's content.
> `printf "v1.0.0" > ./conf.d/YARN_VERSION`
- Create the build files:
> `./scripts/build/setup`
- Build the image:
> `docker build -f carbon.Dockerfile -t my_carbon .`
- Remove the build files:
> `./scripts/build/teardown`
- Find your image:
> `docker images | grep my_carbon`

This may be unnecessarily complicated, but we use this process so that we can open-source our logic, but use internally scanned and tested base images within our own products. See the project at https://github.com/zephinzer/docker-image-alpine-node-internal-use-example for an example of maintaining an internal repository.

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
- [Jasmine](https://github.com/jasmine/jasmine)
- [Helmet](https://github.com/helmetjs/helmet) : HTTP header protection
- [Knex](https://github.com/tgriesser/knex) : Query builder
- [Mocha](https://github.com/mochajs/mocha) : Test framework + runner
- [Mongoose]
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

- [Babel](https://github.com/babel/babel)
- [Chai](https://github.com/chaijs/chai)
- [Enzyme](https://github.com/airbnb/enzyme)
- [ESLint](https://github.com/eslint/eslint)
- [Jasmine](https://github.com/jasmine/jasmine)
- [Jest](https://github.com/facebook/jest)
- [Karma](https://github.com/karma-runner/karma)
- [Mocha](https://github.com/mochajs/mocha)
- [NSP](https://github.com/nodesecurity/nsp)
- [PhantomJS](https://github.com/Medium/phantomjs) (*via `phantomjs-prebuilt`*)
- [React Hot Loader](https://github.com/gaearon/react-hot-loader)
- [Rewire](https://github.com/speedskater/babel-plugin-rewire) (*via `babel-plugin-rewire`*)
- [SASS](https://github.com/sass/node-sass) (*via `node-sass`*)
- [Should](https://github.com/shouldjs/should.js)
- [Sinon](https://github.com/sinonjs/sinon)
- [Webpack](https://github.com/webpack/webpack) + [Webpack Dev Middleware](https://github.com/webpack/webpack-dev-middleware) + [Webpack Hot Middleware](https://github.com/glenjamin/webpack-hot-middleware)

Tests are found in `./test/react-development`. If you wish to add on to this list, please fork this repo, add the packages you need tested and submit a merge request.

## Usage

### In a Dockerfile
Pull the image from DockerHub specifying the approrpriate version:

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

### Release Cycle
The Travis CI script is set to run **every day at least once**, ensuring that latest versions will always be built. Image versions available are from time of first publication (24th September 2017) and includes all versions **after** the following:

- Node Argon v4.8.4
- Node Boron v6.11.3
- Node Carbon v8.5.0
- Yarn 1.0.2

### Release Versioning
This repository contains a [semver](http://semver.org/) versioning system where every successful CI run by Travis increases the PATCH version. There is no need to do anything. Breaking changes will be handled by the maintainers who will update the MAJOR and MINOR versions.

### Force Rebuilding
Occassionally because of security vulnerabilities, it is necessary to rebuild previous containers because the build methodology is broken. For such cases, include a `[force rebuild]` string inside the commit message to force the rebuild of the latest versions.
