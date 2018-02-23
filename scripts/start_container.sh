#!/bin/bash
echo "Pull and start docker images"
export AWS_ACCOUNT_ID=AWS_ACCOUNT_ID_ENV
export AWS_DEFAULT_REGION=AWS_DEFAULT_REGION_ENV
cd ~
docker-compose pull
docker-compose up -d
