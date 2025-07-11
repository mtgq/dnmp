ARG NODE_VERSION=latest
FROM node:${NODE_VERSION}

RUN npm config set registry https://registry.npmmirror.com \
    && yarn config set registry https://registry.npmmirror.com

ARG INSTALL_PNPM=false
RUN if [ ${INSTALL_PNPM} = true ]; then \
    npm install -g pnpm \
    && pnpm config set registry https://registry.npmmirror.com \
;fi

# Set default work directory
WORKDIR /var/www