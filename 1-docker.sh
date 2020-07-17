
## remove old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

## setup the docker repo
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

## add dockers gpg key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo "The Docker key should match this: 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88";

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

## install 
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

## verify
sudo docker run hello-world

sudo usermod -aG docker $(whoami)

## install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

## make the binary executable
sudo chmod +x /usr/local/bin/docker-compose

## install command completion
sudo curl -L https://raw.githubusercontent.com/docker/compose/1.26.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

