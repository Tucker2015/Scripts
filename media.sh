#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io
sudo groupadd docker
sudo usermod -a -G docker $USER

## Install Nginx and Letsencrypt ##

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
<<<<<<< HEAD
    -p 6789:6789 \
    -e PUID=1000 -e PGID=1004 \
    -v /etc/docker/nzbget:/config \
    -v /home/kevin/downloads:/downloads \
    linuxserver/nzbget
=======
	-v /etc/docker/sabnzbd:/config \
    -v /home/kevin/downloads:/downloads \
    -v /home/kevin/downloads/incomplete:/incomplete-downloads \
    -e PGID=1000 -e PUID=1000  \
    -p 8080:8080 -p 9090:9090 \
    -e "VIRTUAL_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
    linuxserver/sabnzbd
>>>>>>> 77a575b44b813a8cd5672f18c9909a8884ffedf2
    
## Install Portainer

docker run -d \
	--name portainer \
	-p 9000:9000 \
	--restart always \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /opt/portainer:/data \
	portainer/portainer
	
## Install Deluge

docker run -d \
  --name deluge \
  --net=host \
  --restart always \
<<<<<<< HEAD
  -e PUID=1000 -e PGID=1004 \
=======
  -e PUID=1000 -e PGID=1000 \
  -e "VIRTUAL_HOST=deluge.kevtucker.com" \
  -e "LETSENCRYPT_HOST=deluge.kevtucker.com" \
  -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
  -e "VIRTUAL_PORT=8112" \
>>>>>>> 77a575b44b813a8cd5672f18c9909a8884ffedf2
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