FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/deb.debian.org/mirrors.huaweicloud.com/g' /etc/apt/sources.list.d/debian.sources && \
    apt-get update && apt-get install -y ca-certificates curl --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ARG NODE_VERSION=node
ENV NODE_VERSION=${NODE_VERSION}
ENV NVM_DIR=/root/.nvm
ARG NPM_REGISTRY=https://registry.npmmirror.com
ENV NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node

RUN mkdir -p $NVM_DIR && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm use ${NODE_VERSION} \
    && nvm alias ${NODE_VERSION} \
    && npm cache clear --force \
    && npm config set registry ${NPM_REGISTRY}

RUN echo "" >> ~/.bashrc && \
    echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc

###########################################################################
# PNPM:
###########################################################################
ARG INSTALL_PNPM=false

RUN if [ ${INSTALL_PNPM} = true ]; then \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    npm install -g pnpm && \
    pnpm config set registry https://registry.npmmirror.com \
;fi

###########################################################################
# YARN:
###########################################################################
ARG INSTALL_YARN=true
ARG YARN_VERSION=latest
ENV YARN_VERSION=${YARN_VERSION}

RUN if [ ${INSTALL_YARN} = true ]; then \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    if [ ${YARN_VERSION} = "latest" ]; then \
        curl -o- -L https://yarnpkg.com/install.sh | bash; \
    else \
        curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version ${YARN_VERSION}; \
    fi && \
    echo "" >> ~/.bashrc && \
    echo 'export PATH="$HOME/.yarn/bin:$PATH"' >> ~/.bashrc && \
    export PATH="$HOME/.yarn/bin:$PATH" && \
    yarn config set registry https://registry.npmmirror.com \
;fi