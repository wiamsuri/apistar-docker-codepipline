#!/bin/bash
echo "Stopping and removing the running container"
cd ~
docker-compose stop
docker-compose rm -f
