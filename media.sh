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
    
    
