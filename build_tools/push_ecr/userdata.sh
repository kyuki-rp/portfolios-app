#!/bin/bash

# docker & docker-composeインストール
sudo yum -y update 
sudo yum -y install docker
sudo systemctl start docker
sudo systemctl enable docker
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# gitインストール
sudo yum install git-all -y

# git clone
git clone https://github.com/kyuki-rp/cloudtools.git /home/ec2-user/cloudtools

# parameter
REGION_NAME=ap-northeast-1
REGISTRY_ID=$((aws sts get-caller-identity) | tr '\n' ' ' | sed -e "s/^.*\"Account\":\s\"\([0-9a-zA-Z]*\)\".*$/\1/g")
# AWS ECR login
aws ecr get-login-password --region ${REGION_NAME} | sudo docker login --username AWS --password-stdin ${REGISTRY_ID}.dkr.ecr.${REGION_NAME}.amazonaws.com
# Building image
sudo su -
docker-compose -f /home/ec2-user/cloudtools/push_ecr/docker_config/docker-compose.yml up -d
sudo docker tag wordpress:latest ${REGISTRY_ID}.dkr.ecr.${REGION_NAME}.amazonaws.com/wordpress:latest
sudo docker push ${REGISTRY_ID}.dkr.ecr.${REGION_NAME}.amazonaws.com/wordpress:latest
sudo docker tag mysql:5.7 ${REGISTRY_ID}.dkr.ecr.${REGION_NAME}.amazonaws.com/mysql:5.7
sudo docker push ${REGISTRY_ID}.dkr.ecr.${REGION_NAME}.amazonaws.com/mysql:5.7