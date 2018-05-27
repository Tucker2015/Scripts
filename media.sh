#!/bin/bash

sudo groupadd docker
sudo usermod -a -G docker $USER


## Install Sonarr

docker run -d \
    --name sonarr \
    --restart always \
    -p 8989:8989 \
    -e PUID=1000 -e PGID=1000 \
    -v /etc/docker/sonarr:/config \
    -v /mnt/media/tv:/tv \
    -v /home/kevin/downloads:/downloads \
    -e "VIRTUAL_HOST=sonarr.kevtucker.com" \
    -e "LETSENCRYPT_HOST=sonarr.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
    linuxserver/sonarr

## Install Radarr
    
docker run -d \
  --name=radarr \
  --restart always \
    -v /etc/docker/radarr:/config \
    -v /home/kevin/downloads:/downloads \
    -v /mnt/media/movies:/movies \
    -e PGID=1000 -e PUID=1000  \
    -p 7878:7878 \
    -e "VIRTUAL_HOST=radarr.kevtucker.com" \
    -e "LETSENCRYPT_HOST=radarr.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
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
	-v /etc/docker/sabnzbd:/config \
    -v /home/kevin/downloads:/downloads \
    -v /home/kevin/downloads/incomplete:/incomplete-downloads \
    -e PGID=1000 -e PUID=1000  \
    -p 8080:8080 -p 9090:9090 \
    -e "VIRTUAL_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \

## Install Portainer

docker run -d \
	--name portainer \
	-p 9000:9000 \
	--restart always \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /opt/portainer:/data \
	-e "VIRTUAL_HOST=docker.kevtucker.com" \
    -e "LETSENCRYPT_HOST=docker.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
	portainer/portainer
	
## Install Deluge

docker run -d \
  --name deluge \
  --net=host \
  --restart always \
  -e PUID=1000 -e PGID=1000 \
  -e "VIRTUAL_HOST=deluge.kevtucker.com" \
  -e "LETSENCRYPT_HOST=deluge.kevtucker.com" \
  -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
  -e "VIRTUAL_PORT=8112" \
  -v ~/downloads:/downloads \
  -v /etc/docker/deluge:/config \
  linuxserver/deluge

## Install Ghost

docker run -d \
--name blog \
--restart always \
-p 2368:2368 \
-e PUID=1000 -e PGID=1000 \
-e url=https://ghost.kevtucker.com \
-e VIRTUAL_PORT=2368 \
-e VIRTUAL_HOST=ghost.kevtucker.com \
-e LETSENCRYPT_MAIL=mail@kevtucker.com \
-e LETSENCRYPT_HOST=ghost.kevtucker.com \
-v /etc/docker/ghost/:/var/lib/ghost/content \
ghost:latest