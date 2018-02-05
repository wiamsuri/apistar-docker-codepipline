#!/bin/bash
docker run --name api-star -dp 80:5000 AWS_ACCOUNT_ID.dkr.ecr.AWS_DEFAULT_REGION.amazonaws.com/api-star:latest
