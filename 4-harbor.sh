#!/usr/bin/env bash
set -euxo pipefail

sudo ./harbor/prepare
sudo ./harbor/install.sh --with-trivy --with-clair
