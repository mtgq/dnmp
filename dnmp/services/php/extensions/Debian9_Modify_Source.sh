#!/bin/sh

SYSTEM_VERSION_NUMBER="$(cat /etc/os-release | grep -E "^VERSION_ID=" | awk -F '=' '{print$2}' | sed "s/[\'\"]//g")"

\cp /etc/apt/sources.list /etc/apt/sources.list.$(date +"%Y%m%d")

    if [ "${SYSTEM_VERSION_NUMBER}" -eq "9" ]; then
        cat > /etc/apt/sources.list<<EOF
deb http://mirrors.aliyun.com/debian-archive/debian stretch main contrib non-free
deb http://mirrors.aliyun.com/debian-archive/debian stretch-proposed-updates main non-free contrib
deb http://mirrors.aliyun.com/debian-archive/debian stretch-backports main non-free contrib
deb http://mirrors.aliyun.com/debian-archive/debian-security stretch/updates main contrib non-free
EOF
    elif [ "${SYSTEM_VERSION_NUMBER}" -eq "10" ]; then
        cat > /etc/apt/sources.list<<EOF
deb http://mirrors.aliyun.com/debian-archive/debian stretch main
deb http://mirrors.aliyun.com/debian-archive/debian stretch-proposed-updates main
deb http://mirrors.aliyun.com/debian-archive/debian stretch-backports main
deb http://mirrors.aliyun.com/debian-archive/debian-security stretch/updates main
EOF
    elif [ "${SYSTEM_VERSION_NUMBER}" -eq "11" ]; then
        cat > /etc/apt/sources.list<<EOF
deb https://mirrors.ustc.edu.cn/debian/ bullseye main contrib non-free
deb https://mirrors.ustc.edu.cn/debian/ bullseye-updates main contrib non-free
deb https://mirrors.ustc.edu.cn/debian/ bullseye-backports main contrib non-free
deb https://mirrors.ustc.edu.cn/debian-security/ bullseye-security main contrib non-free
EOF
    elif [ "${SYSTEM_VERSION_NUMBER}" -eq "12" ]; then
        rm -rf /etc/apt/sources.list.d/debian.sources
        cat > /etc/apt/sources.list<<EOF
deb https://mirrors.ustc.edu.cn/debian/ bookworm main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ bookworm-updates main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian/ bookworm-backports main contrib non-free non-free-firmware
deb https://mirrors.ustc.edu.cn/debian-security/ bookworm-security main contrib non-free non-free-firmware
EOF
    fi

apt update -y

apt-get install wget