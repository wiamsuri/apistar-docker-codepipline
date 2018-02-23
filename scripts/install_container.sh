#!/bin/bash
echo "Pulling dependencies"
LOGIN_COMMAND
export AWS_ACCOUNT_ID=AWS_ACCOUNT_ID_ENV
export AWS_DEFAULT_REGION=AWS_DEFAULT_REGION_ENV
docker-compose pull
