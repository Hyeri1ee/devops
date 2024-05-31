#!/bin/bash
sudo su -
sudo apt-get update
sudo apt install -y docker.io
sudo apt-get install -y git
#install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo systemctl start docker
sudo systemctl enable docker
#git clone specific branch
git clone -b feature/fourth-task --single-branch https://gitlab.com/saxion.nl/hbo-ict/2.3-devops/2023-2024/exam-retake/03.git
cd 03
sudo docker-compose up -d