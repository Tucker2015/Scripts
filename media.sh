#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io
sudo groupadd docker
sudo usermod -a -G docker $USER

## Install Unifi Controller ##

docker create \
  --name=unifi \
  --restart always \
  -v /etc/docker/unifi:/config \
  -e PGID=1004 -e PUID=1000  \
  -p 3478:3478/udp \
  -p 10001:10001/udp \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8443:8443 \
  -p 8843:8843 \
  -p 8880:8880 \
  -p 6789:6789 \
  linuxserver/unifi

## Install Sonarr

docker run -d \
    --name sonarr \
    --restart always \
    -p 8989:8989 \
    -e PUID=1000 -e PGID=1004 \
    -v /etc/docker/sonarr:/config \
    -v /mnt/media/tv:/tv \
    -v /home/kevin/downloads:/downloads \
    linuxserver/sonarr

## Install Radarr
    
docker run -d \
  --name=radarr \
  --restart always \
    -v /etc/docker/radarr:/config \
    -v /home/kevin/downloads:/downloads \
    -v /mnt/media/movies:/movies \
    -e PGID=1000 -e PUID=1004  \
    -p 7878:7878 \
    linuxserver/radarr

## Install Nzbget
  
#docker run -d \
#    --name nzbget \
#    --restart always \
#    -p 6789:6789 \
#    -e PUID=1000 -e PGID=1000 \
#    -v /etc/docker/nzbget:/config \
#    -v /home/kevin/downloads:/downloads \
#    -e "VIRTUAL_HOST=nzb.kevtucker.com" \
#    -e "LETSENCRYPT_HOST=nzb.kevtucker.com" \
#    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
#   linuxserver/nzbget

## Install SabNZBD ##

docker run -d \
	--name sabnzb \
    --restart always \
    -p 6789:6789 \
    -e PUID=1000 -e PGID=1004 \
    -v /etc/docker/nzbget:/config \
    -v /home/kevin/downloads:/downloads \
    linuxserver/nzbget
	-v /etc/docker/sabnzbd:/config \
    -v /home/kevin/downloads:/downloads \
    -v /home/kevin/downloads/incomplete:/incomplete-downloads \
    -e PGID=1000 -e PUID=1000  \
    -p 8080:8080 -p 9090:9090 \
    linuxserver/sabnzbd

    
## Install Portainer

docker run -d \
	--name portainer \
	-p 9000:9000 \
	--restart always \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /opt/portainer:/data \
	portainer/portainer
	


