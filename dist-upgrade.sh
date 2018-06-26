#!/bin/bash

sudo apt update && sudo apt dist-upgrade -y && sudo apt autoremove -y
sudo apt-get install update-manager-core -y
sudo do-release-upgrade -d -y