#!/bin/bash

su - 
sudo apt update
sudo apt install ca-certificates curl
sudo apt install -m 0755 -d /etc/apt/keyrings
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc 
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl status docker
sudo systemctl start docker
sudo docker run hello-world
sudo apt-get install docker-compose-plugin
docker compose version

mkdir ai-tools
cd ai-tools/
mkdir n8n
cd n8n
vi docker-compose.yml
vi .env
vi init-data.sh
chmod +x init-data.sh 
docker compose up
sudo systemctl start docker
docker compose up
sudo groupadd docker
sudo usermod -aG docker derik
sudo systemctl enable docker.service
sudo systemctl enable contsinerd.service
sudo systemctl enable containerd.service
