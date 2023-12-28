#!/usr/bin/env bash
set -euxo pipefail

DOMAIN="harbor.example.net"
EMAIL="user@example.net"

sudo apt-get install --yes certbot
sudo certbot certonly --standalone -d $DOMAIN --preferred-challenge http --agree-tos -n -m $EMAIL --keep-until-expiring

exit

## Everything below was taken from the online
## Harbor install docs. They don't work. They can be removed.

mkdir ./certs
cd ./certs

## Cert authority

openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=GA/L=Atlanta/O=cloudfive/OU=DevSecOps/CN=$DOMAIN" \
 -key ca.key \
 -out ca.crt

## Server cert

openssl genrsa -out $DOMAIN.key 4096

openssl req -sha512 -new \
    -subj "/C=CN/ST=GA/L=Atlanta/O=cloudfive/OU=DevSecOps/CN=$DOMAIN" \
    -key $DOMAIN.key \
    -out $DOMAIN.csr


## Create V3.ext

cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=docker.cloudfive.net
DNS.2=images.cloudfive.net
DNS.3=registry.cloudfive.net
EOF

## generate harbor cert

openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in $DOMAIN.csr \
    -out $DOMAIN.crt

## copy the certs

sudo mkdir -p /data/cert/
sudo cp $DOMAIN.crt /data/cert/
sudo cp $DOMAIN.key /data/cert/

## convert the cert

openssl x509 -inform PEM -in $DOMAIN.crt -out $DOMAIN.cert

## copy certs more

sudo mkdir -p /etc/docker/certs.d/$DOMAIN/

sudo cp $DOMAIN.crt /etc/docker/certs.d/$DOMAIN/
sudo cp $DOMAIN.cert /etc/docker/certs.d/$DOMAIN/
sudo cp $DOMAIN.key /etc/docker/certs.d/$DOMAIN/
sudo cp ca.crt /etc/docker/certs.d/$DOMAIN/
sudo cp ca.key /etc/docker/certs.d/$DOMAIN/

## copy certs to Ubuntu OS

sudo cp $DOMAIN.crt /usr/local/share/ca-certificates/$DOMAIN.crt
sudo update-ca-certificates

## restart docker

sudo systemctl restart docker


