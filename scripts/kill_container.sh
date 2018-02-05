#!/bin/bash
echo "Stopping and removing the running container"
docker stop api-star
docker rm -f api-star
