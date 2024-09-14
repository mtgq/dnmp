#!/bin/sh

export MC="-j$(nproc)"

Download_Mirror='https://soft.lnmp.com'

echo
echo "============================================"
echo "Install extensions from   : startup.sh"
echo "PHP version               : ${LARADOCK_PHP_VERSION}"
echo "Multicore Compilation     : ${MC}"
echo "Work directory            : ${PWD}"
echo "============================================"
echo

#
# Install extension from package file(.tgz),
# For example:
#
# installExtensionFromTgz redis-5.2.2
#
# Param 1: Package name with version
# Param 2: enable options
#
installExtensionFromTgz()
{
    tgzName=$1
    result=""
    extensionName="${tgzName%%-*}"
    shift 1
    result=$@
    mkdir ${extensionName}
    tar -xf ${tgzName}.tgz -C ${extensionName} --strip-components=1
    ( cd ${extensionName} && phpize && ./configure ${result} && make ${MC} && make install )

    docker-php-ext-enable ${extensionName}
    rm -rf ${extensionName}
}

Download_Files()
{
    local URL=$1
    local FileName=$2
    if [ -s "${FileName}" ]; then
        echo "${FileName} [found]"
    else
        echo "Notice: ${FileName} not found!!!download now..."
        wget -c --progress=dot -e dotbytes=20M --prefer-family=IPv4 --no-check-certificate ${URL}
    fi
}

Install_Composer

echo "====== Installing PHP Swoole ======"
if echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^8.[0-3]'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-5.1.1.tgz swoole-5.1.1.tgz
    installExtensionFromTgz swoole-5.1.1 --enable-openssl --enable-http2 --enable-swoole-json
elif echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^7.[2-4]'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-4.8.13.tgz swoole-4.8.13.tgz
    installExtensionFromTgz swoole-4.8.13 swoole-4.8.13 --enable-openssl --enable-http2 --enable-swoole-json
elif echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^7.1'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-4.5.11.tgz swoole-4.5.11.tgz
    installExtensionFromTgz swoole-4.5.11 --enable-openssl --enable-http2 --enable-swoole-json
elif echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^7.0'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-4.3.6.tgz swoole-4.3.6.tgz
    installExtensionFromTgz swoole-4.3.6 --enable-openssl --enable-http2
elif echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^5.[3-6]'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-1.10.5.tgz swoole-1.10.5.tgz
    installExtensionFromTgz swoole-1.10.5 --enable-openssl
elif echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^5.2'; then
    Download_Files ${Download_Mirror}/web/swoole/swoole-1.6.10.tgz swoole-1.6.10.tgz
    installExtensionFromTgz swoole-1.6.10 --enable-openssl
fi

Install_Composer()
{
    echo "Downloading Composer..."
    if echo "${LARADOCK_PHP_VERSION}" | grep -Eqi '^5.[2-6]|7.[0-2]'; then
        wget --progress=dot:giga --prefer-family=IPv4 --no-check-certificate -T 120 -t3 ${Download_Mirror}/web/php/composer/composer-2.2.phar -O /usr/local/bin/composer
        if [ $? -eq 0 ]; then
            echo "Composer install successfully."
            chmod +x /usr/local/bin/composer
        else
            echo "Composer install failed, try to from composer official website..."
            curl -sS --connect-timeout 30 -m 60 https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --2.2
            if [ $? -eq 0 ]; then
                echo "Composer install successfully."
            fi
        fi
    else
        wget --progress=dot:giga --prefer-family=IPv4 --no-check-certificate -T 120 -t3 https://mirrors.aliyun.com/composer/composer.phar -O /usr/local/bin/composer
        if [ $? -eq 0 ]; then
            echo "Composer install successfully."
            chmod +x /usr/local/bin/composer
        else
            echo "Composer install failed, try to from composer official website..."
            curl -sS --connect-timeout 30 -m 60 https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
            if [ $? -eq 0 ]; then
                echo "Composer install successfully."
            fi
        fi
    fi
}