#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io
sudo groupadd docker
sudo usermod -a -G docker $USER


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
  
docker run -d \
    --name nzbget \
    --restart always \
    -p 6789:6789 \
    -e PUID=1000 -e PGID=1004 \
    -v /etc/docker/nzbget:/config \
    -v /home/kevin/downloads:/downloads \
    linuxserver/nzbget
    
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
  -e PUID=1000 -e PGID=1004 \
  -v ~/downloads:/downloads \
  -v /etc/docker/deluge:/config \
  linuxserver/deluge