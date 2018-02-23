#!/bin/bash
echo "Stopping and removing the running container"
docker-compose stop
docker-compose rm -f
