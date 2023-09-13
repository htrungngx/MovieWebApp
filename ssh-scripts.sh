#! /bin/bash

sudo apt-get update && sudo apt-get upgrade -y

sudo docker pull dckb9xz/app:latest

sudo docker ps -a
sudo docker rm -f movieapp || echo 'The container does not exist'
sudo docker run --name movieapp -p 3000:3000 -d dckb9xz/app