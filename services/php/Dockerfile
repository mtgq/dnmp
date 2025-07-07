ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ARG TZ
ARG PHP_EXTENSIONS

ENV TZ=${TZ}

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN set -eux; \
    File_LinuxRelease=/etc/os-release; \
    SYSTEM_VERSION_ID="$(cat $File_LinuxRelease | grep -E "^VERSION_ID=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"; \
    SYSTEM_VERSION_ID_MAJOR="${SYSTEM_VERSION_ID%.*}"; \
    if [ "$SYSTEM_VERSION_ID_MAJOR" = "8" ]; then \
        RELEASE_CODENAME="jessie"; \
    elif [ "$SYSTEM_VERSION_ID_MAJOR" = "9" ]; then \
        RELEASE_CODENAME="stretch"; \
    elif [ "$SYSTEM_VERSION_ID_MAJOR" = "10" ]; then \
        RELEASE_CODENAME="buster"; \
    fi; \
    if [ "$SYSTEM_VERSION_ID_MAJOR" = "8" ] || [ "$SYSTEM_VERSION_ID_MAJOR" = "9" ] || [ "$SYSTEM_VERSION_ID_MAJOR" = "10" ]; then \
        sed -i 's/^deb /# deb /g' /etc/apt/sources.list; \
        echo "deb http://archive.debian.org/debian/ ${RELEASE_CODENAME} main contrib non-free" >> /etc/apt/sources.list; \
        echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until; \
        apt-get update -o Acquire::Check-Valid-Until=false; \
        apt-get install -y --allow-unauthenticated debian-archive-keyring; \
    fi; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y --no-install-recommends \
            tzdata \
            curl; \
    rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN curl -sSLf -o /usr/local/bin/install-php-extensions https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions \
&& chmod +x /usr/local/bin/install-php-extensions \
&& install-php-extensions @composer @fix_letsencrypt $PHP_EXTENSIONS

# Update composer
ARG COMPOSER_VERSION=2
ENV COMPOSER_VERSION ${COMPOSER_VERSION}
RUN set -eux; \
      if [ "$COMPOSER_VERSION" = "1" ] || [ "$COMPOSER_VERSION" = "2" ] || [ "$COMPOSER_VERSION" = "2.2" ]; then \
          composer self-update --${COMPOSER_VERSION}; \
      else \
          composer self-update; \
      fi

#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

COPY ./laravel.ini /usr/local/etc/php/conf.d
COPY ./xlaravel.pool.conf /usr/local/etc/php-fpm.d/

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f /var/log/lastlog /var/log/faillog

# Configure non-root user.
RUN groupmod -o -g 1000 www-data && \
    usermod -o -u 1000 -g www-data www-data

# Set work directory
WORKDIR /var/www