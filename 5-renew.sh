#!/usr/bin/env bash
set -euxo pipefail

sudo ./harbor/docker compose down
sudo certbot renew
sudo ./harbor/prepare
sudo docker compose up
