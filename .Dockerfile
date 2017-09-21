FROM iron/base:3.4
LABEL maintainer="dev@joeir.net" \
      version="1.0.0" \
      description="A minimal Node + Yarn base image to work with."
ENV INSTALL_PATH=/tmp
ENV APK_TO_INSTALL="bash curl gcc g++ make python linux-headers binutils-gold libstdc++ gnupg"
ENV APK_TO_REMOVE="curl gcc g++ make python binutils-gold gnupg"
ENV APPLICATION_WORKING_DIRECTORY=/app
ENV NODE_VERSION=v__NODE_VERSION__
ENV NODE_URL=https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}.tar.xz
ENV NODE_GPG_URL=https://nodejs.org/dist/${NODE_VERSION}/SHASUMS256.txt.asc
ENV NODE_INSTALL_PATH=${INSTALL_PATH}/node.tar.xz
ENV NODE_INSTALL_GPG_PATH=${NODE_INSTALL_PATH}.asc
ENV NODE_INSTALL_DIR=${INSTALL_PATH}/node-${NODE_VERSION}
ENV NODE_BUILD_FLAGS="--without-intl --fully-static"
ENV PATHS_TO_REMOVE="\
  ${INSTALL_PATH}/* \
  /root/.gnupg \
  /root/.node-gyp \
  /root/.npm \
  /usr/include \
  /usr/lib/node_modules/npm/man \
  /usr/lib/node_modules/npm/doc \
  /usr/lib/node_modules/npm/html \
  /usr/lib/node_modules/npm/scripts \
  /usr/share/man \
  /var/cache/apk"
ENV SYSTEM_BIN_PATH=/usr/local/bin/
ENV YARN_VERSION=v1.0.2
ENV YARN_URL=https://github.com/yarnpkg/yarn/releases/download/${YARN_VERSION}/yarn-${YARN_VERSION}.tar.gz
ENV YARN_GPG_URL=https://github.com/yarnpkg/yarn/releases/download/${YARN_VERSION}/yarn-${YARN_VERSION}.tar.gz.asc
ENV YARN_GPG_KEY_URL=https://dl.yarnpkg.com/debian/pubkey.gpg
ENV YARN_INSTALL_PATH=${INSTALL_PATH}/yarn.tar.gz
ENV YARN_INSTALL_GPG_PATH=${YARN_INSTALL_PATH}.asc
ENV YARN_INSTALL_DIR=${INSTALL_PATH}/yarn-${YARN_VERSION}
ENV YARN_INSTALLED_PATH=/usr/local/share/yarn/
ENV FONT_RESET="\033[0m"
ENV FONT_BOLD="\033[1m"
ENV FONT_DIM="\033[2m"
ENV FONT_GREEN="\033[32m"
RUN printf "${FONT_BOLD}${FONT_GREEN} \n\
    _____________ \n\
    BEGIN:<setup> \n\
    ^^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    apk update && \
    apk upgrade && \
    apk add --no-cache ${APK_TO_INSTALL} && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ____________ \n\
    END:</setup> \n\
    ^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ____________________ \n\
    BEGIN:<install-yarn> \n\
    ^^^^^^^^^^^^^^^^^^^^ \n\
    # gpg keys retrieval from method within <https://yarnpkg.com/install.sh> \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    curl -sS ${YARN_GPG_KEY_URL} | gpg --import && \
    curl -sSL ${YARN_URL} -o ${YARN_INSTALL_PATH} && \
    curl -sSL ${YARN_GPG_URL} -o ${YARN_INSTALL_GPG_PATH} && \
    gpg --verify ${YARN_INSTALL_GPG_PATH} && \
    mkdir -p ${YARN_INSTALLED_PATH} && \
    tar -xf ${YARN_INSTALL_PATH} -C ${INSTALL_PATH} && \
    mv ${YARN_INSTALL_DIR}/* ${YARN_INSTALLED_PATH} && \
    ln -s ${YARN_INSTALLED_PATH}/bin/yarn ${SYSTEM_BIN_PATH} && \
    ln -s ${YARN_INSTALLED_PATH}/bin/yarnpkg ${SYSTEM_BIN_PATH} && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ___________________ \n\
    END:</install-yarn> \n\
    ^^^^^^^^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ____________________ \n\
    BEGIN:<install-node> \n\
    ^^^^^^^^^^^^^^^^^^^^ \n\
    # gpg keys retrieval from url <https://github.com/nodejs/node/#release-team> \n
    ${FONT_RESET}${FONT_DIM}\n" && \
    gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
      56730D5401028683275BD23C23EFEFE93C4CFFFE && \
    curl -sSL ${NODE_URL} -o ${NODE_INSTALL_PATH} && \
    curl -sSL ${NODE_GPG_URL} -o ${NODE_INSTALL_GPG_PATH} && \
    gpg --verify ${NODE_INSTALL_GPG_PATH} && \
    tar -xf ${NODE_INSTALL_PATH} -C ${INSTALL_PATH} && \
    cd ${NODE_INSTALL_DIR} && \
    ./configure ${NODE_BUILD_FLAGS} && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install | grep 'installing' && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ___________________ \n\
    END:</install-node> \n\
    ^^^^^^^^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    ________________ \n\
    BEGIN:<teardown> \n\
    ^^^^^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    apk del ${APK_TO_REMOVE} && \
    rm -rf ${PATHS_TO_REMOVE} && \
    printf "${FONT_BOLD}${FONT_GREEN} \n\
    _______________ \n\
    END:</teardown> \n\
    ^^^^^^^^^^^^^^^ \n\
    ${FONT_RESET}${FONT_DIM}\n" && \
    mkdir -p /app
WORKDIR ${APPLICATION_WORKING_DIRECTORY}