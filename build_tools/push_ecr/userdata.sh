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
# wp
# docker-compose -f /home/ec2-user/cloudtools/build_tools/push_ecr/docker_config/docker-compose.yml up -d
# sudo docker tag wordpress:latest ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/wordpress:latest
# sudo docker push ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/wordpress:latest
# sudo docker tag mysql:5.7 ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/mysql:5.7
# sudo docker push ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/mysql:5.7

# traefik
docker-compose -f /home/ec2-user/cloudtools/build_tools/push_ecr/docker_config/docker-compose.yml up -d
docker tag traefik:v1.4.1-alpine ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/traefik:latest
docker push ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/traefik:latest

# whoami
docker tag traefik/whoami:latest ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/whoami:latest
docker push ${aws_account_id}.dkr.ecr.${region_name}.amazonaws.com/whoami:latest