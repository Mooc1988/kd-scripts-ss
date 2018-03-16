#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin;
export PATH

function check_git(){
  if ! [ -x "$(command -v git)" ]; then
    apt update
    apt install -y git
  fi
}

function check_scripts(){
  if [ ! -d "/home/kd-scripts-ss" ]; then
    cd /home
    git clone https://github.com/Mooc1988/kd-scripts-ss.git
  else
    cd /home/kd-scripts-ss
    git pull
  fi
}


check_git
check_scripts
bash /home/kd-scripts-ss/deploy.sh