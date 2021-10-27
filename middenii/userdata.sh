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
git clone https://github.com/kyuki-rp/portfolios-app.git /home/ec2-user/cloudtools

# AWS ECR login
aws ecr get-login-password --region ${region_name} | sudo docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com
# Building image
sudo su -

# docker compose
docker-compose -f /home/ec2-user/cloudtools/middenii/docker_config/traefik/docker-compose.yml up -d
docker-compose -f /home/ec2-user/cloudtools/middenii/docker_config/fastapi/docker-compose.yml up -d
