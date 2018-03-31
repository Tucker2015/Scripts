#!/bin/bash

# My first script to setup Ubuntu 16.04 Linux to install Docker.

### Install system needed updates ###

# ensure running as root
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@" 
fi

apt update -y
dpkg --configure -a
apt upgrade -y
apt install -y unzip wget curl git

### Install Docker Components ###

apt-get update
apt-get install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"


apt-get update -y
apt-get install docker-ce -y
systemctl enable docker
groupadd docker
usermod -a -G docker $USER

### Create a key for SSH login

ssh-keygen -t rsa -N "" -f ~/id_rsa

clear

echo "Please Reboot the system by running sudo reboot"