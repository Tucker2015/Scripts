#!/bin/bash


## Script for add telegraf to influxdb ##

sudo add-apt-repository deb https://repos.influxdata.com/debian jessie stable

curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -

apt update
apt install telegraf -y