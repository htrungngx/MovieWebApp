#! /bin/bash

##These are scripts to pull and run docker container on production environment
sudo apt-get update && sudo apt-get upgrade -y

sudo docker pull dckb9xz/app:latest

sudo docker ps -a
sudo docker rm -f movieapp || echo 'The container does not exist'
sudo docker run --name movieapp -p 3000:3000 -d --restarted unless-stopped dckb9xz/app