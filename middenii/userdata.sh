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

# jqインストール
sudo yum -y install jq

# git clone
git clone https://github.com/kyuki-rp/portfolios-app.git /home/ec2-user/cloudtools

# Building image
sudo su -

# Create network
docker network create web

# traefik docker-compose up
docker-compose -f /home/ec2-user/cloudtools/middenii/docker/traefik/docker-compose.yml up --build -d

# zodiac app docker-compose up
cd /home/ec2-user/cloudtools/middenii/docker/zodiac
export app_name="zodiac1"
docker-compose up --build -d


