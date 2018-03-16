#! /bin/bash

function install_ss(){
    if ! [ -x "$(command -v ss-server)" ]; then
        if grep -Eqi "16.04" /etc/issue ; then
          apt-get install software-properties-common -y
          add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
        fi
        apt-get update
        apt install shadowsocks-libev -y
    fi
}

function install_supervisor(){
    if ! [ -x "$(command -v supervisorctl)" ]; then
        apt update
        apt install supervisor -y
    fi
}

function optimize_ss(){
    cp /home/kd-scripts-ss/config/shadowsocks-libev /etc/default/shadowsocks-libev
    sysctl --system
    adduser --system --disabled-password --disabled-login --no-create-home shadowsocks
    cp /home/kd-scripts-ss/config/local.conf /etc/sysctl.d/local.conf
}

function config_iptables(){
    if ! [ -f "/etc/iptables/rules.v4"]; then
        cp /home/kd-scripts-ss/config/rules.v4 /etc/iptables/rules.v4
    fi
    iptables-restore /etc/iptables/rules.v4
}

function install(){
    install_ss
    install_supervisor
    optimize_ss
    config_iptables
}

install

