#!/bin/bash
echo "Pulling dependencies"
LOGIN_COMMAND
docker pull AWS_ACCOUNT_ID.dkr.ecr.AWS_DEFAULT_REGION.amazonaws.com/api-star:latest
