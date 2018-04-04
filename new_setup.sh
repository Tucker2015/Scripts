#!/bin/bash

# Just testing a few snippets from various scripts to see how they work


function _askservices() {
  DISTRO=$(lsb_release -is)
  RELEASE=$(lsb_release -rs)
  CODENAME=$(lsb_release -cs)
  SETNAME=$(lsb_release -rc)
  echo "You are running $DISTRO $CODENAME"
  echo "This distribution has support for systemd services. "
  echo "Would you like to enable? (recommended) (Default: ${green}${bold}Y${normal})"; read input
    case $input in
      [yY] | [yY][Ee][Ss] | "" ) cron="no";echo "${bold}Using systemd for process management${normal}" ;;
      [nN] | [nN][Oo] ) cron="yes";echo "${cyan}Cron will manage your processes${normal}" ;;
    *) cron="no";echo "${bold}Using systemd for process management${normal}" ;;
    esac
  echo
}
