#!/bin/bash


## Install Sonarr

docker run -d \
    --name sonarr \
    -p 8989:8989 \
    -e PUID=1000 -e PGID=1000 \
    -v /etc/docker/sonarr:/config \
    -v /mnt/media/tv:/tv \
    -v /home/kevin/downloads:/downloads \
    -e "VIRTUAL_HOST=sonarr.kevtucker.com" \
    -e "LETSENCRYPT_HOST=sonarr.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
    linuxserver/sonarr
    
docker run -d \
  --name=radarr \
    -v /etc/docker/radarr:/config \
    -v /home/kevin/downloads:/downloads \
    -v /mnt/media:/movies \
    -e PGID=1000 -e PUID=1000  \
    -p 7878:7878 \
    -e "VIRTUAL_HOST=radarr.kevtucker.com" \
    -e "LETSENCRYPT_HOST=radarr.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
    linuxserver/radarr
  
docker run -d \
    --name nzbget \
    -p 6789:6789 \
    -e PUID=1000 -e PGID=1000 \
    -v /etc/docker/nzbget:/config \
    -v /home/kevin/downloads:/downloads \
    -e "VIRTUAL_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_HOST=nzb.kevtucker.com" \
    -e "LETSENCRYPT_EMAIL=mail@kevtucker.com" \
    linuxserver/nzbget