# API Star Docker CodePipeline
This repository includes code to launch an API Star project to AWS CodeDeploy while using AWS CodeBuild to build the docker image.

## Pipeline Overview
GitHub -> AWS CodeBuild -> AWS ElasticContainerRepository -> AWS CodeDeploy

The code committed to GitHub should trigger AWS CodePipeline to bundle the source code and send to AWS CodeBuild. The AWS CodeBuild looks for a file named `buildspec.yml` at the root level of the repository. This file provides CodeBuild instructions of how to build the code. CodeBuild builds docker image and push the image to AWS ElasticContainerRepository(ECR). In the last section of `buildspec.yml`, the `artifacts` gives CodeBuild instruction to save the scripts and send to AWS CodeDeploy for retrieving docker image from ECR. CodeDeploy will receive the zip file containing `appspec.yml` at root level. CodeDeploy will then use instructions from `appspec.yml` to get the new docker image up on EC2 instances.

### Launch Configuration for new EC2 instances
After choosing the instance type for the launch configuration, you will need to add `AmazonEC2RoleforAWSCodeDeploy` policy to the IAM role that will be assigned to new EC2 in this launch configuration.

Add the following lines to "User data" section. You may find this in the "Advanced Details" section while setting up the configuration. Change the region name(on the line with curl) of the S3 bucket to have correct installation for your EC2 instances.
```
#!/bin/bash
sudo yum -y update
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo service docker start
sudo pip install docker-compose
curl -O https://aws-codedeploy-ap-southeast-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
```

### Permission for AWS CodeBuild to push and pull docker images from ECR(ElasticContainerRepository)
The IAM role assigned to AWS CodeBuild should have the following policies
```
"Action": [
    "ecr:BatchCheckLayerAvailability",
    "ecr:CompleteLayerUpload",
    "ecr:GetAuthorizationToken",
    "ecr:InitiateLayerUpload",
    "ecr:PutImage",
    "ecr:UploadLayerPart",
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage"
]
```
The full policy JSON will look something like
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "ecr:BatchCheckLayerAvailability",
                "ecr:CompleteLayerUpload",
                "ecr:GetAuthorizationToken",
                "ecr:InitiateLayerUpload",
                "ecr:PutImage",
                "ecr:UploadLayerPart",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
```

While configuring AWS CodeBuild, you will need to specify following environment variables:
```
AWS_ACCOUNT_ID
AWS_DEFAULT_REGION
```
