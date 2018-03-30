#!/bin/bash

# My first script to setup Ubuntu 16.04 Linux to install Docker.

### Install system needed updates ###

apt update -y
apt upgrade -y
apt install -y unzip wget curl git

### Install Docker Components ###

apt-get update
sudo apt-get install \
apt-transport-https \
ca-certificates \
curl \
software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

apt-get update -y
apt-get install docker-ce
systemctl enable docker
groupadd docker
usermod -aG docker $USER