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

# Building image
sudo su -

# Create network
docker network create web

# docker-compose up
docker-compose -f /home/ec2-user/cloudtools/middenii/docker/traefik/docker-compose.yml up --build -d

cd /home/ec2-user/cloudtools/middenii/docker/zodiac
docker-compose build
docker-compose run zodiac_frontend sh -c "npm init -y && npm install -D webpack webpack-cli webpack-dev-server typescript ts-loader @types/react @types/react-dom react-router-dom @types/react-router-dom axios bootstrap css-loader style-loader react-bootstrap && npm install react react-dom"
docker-compose up -d