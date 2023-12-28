#!/usr/bin/env bash
set -euxo pipefail

RED="\e[31m"
GREEN="\e[32m"
CYAN="\033[0;36m"
NC="\e[0m"

## remove old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

## setup the docker repo
sudo apt-get update

sudo apt-get install --yes \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

## add dockers gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "The Docker key should match this: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88";

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository --yes \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

## install 
sudo apt-get update
sudo apt-get install --yes docker-ce docker-ce-cli containerd.io docker-compose-plugin

# add user to docker group
sudo usermod -aG docker $(whoami)

## verify
sudo docker run hello-world

echo -e "${CYAN}$(docker --version)${NC}"
echo -e "${CYAN}$(docker compose version)${NC}"

