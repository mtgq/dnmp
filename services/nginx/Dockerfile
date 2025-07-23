FROM nginx:latest

RUN sed -i "s|deb.debian.org|mirrors.ustc.edu.cn|g" /etc/apt/sources.list.d/debian.sources && apt update

WORKDIR /var/www