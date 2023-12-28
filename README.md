# Setup Harbor on Ubuntu
These scripts are a quick way to setup Harbor on Ubuntu.

They can be easily modified to run on RHEL.

### Install Docker

run `./1-docker.sh`

### Download Harbor

Change the `VERSION` to the latest Harbor version.
Harbor versions can be found [here](https://github.com/goharbor/harbor/releases).

run `./2-download.sh`

### Configure HTTPS

Change the `DOMAIN` and `EMAIL` variables at the top of the script.

run `./3-https.sh`

### Configure and run Harbor

1. Modify the `harbor.yml` file and replace with custom values:

    * `hostname: harbor.example.net`

    * `certificate: /etc/letsencrypt/live/harbor.example.net/fullchain.pem`

    * `private_key: /etc/letsencrypt/live/harbor.example.net/privkey.pem`

**Optional**: Change the `./4-harbor.sh` script to run without _clair_ 

NOTE: _notary_ and _chartmuseum_ have been deprecated.

run `./4-harbor.sh`

### Renew certs

The process: stop Harbor, renew the certs, start Harbor:

run `5-renew.sh`

NOTE: Check `/var/log/harbor/proxy.log` if there are errors with the cert renewal.

## References

LetsEncypt install: https://certbot.eff.org/lets-encrypt/ubuntufocal-other

Harbor LetsEncypt certs: https://computingforgeeks.com/how-to-install-harbor-docker-image-registry-on-centos-debian-ubuntu/

Renew certs: https://medium.com/@udomsak/upgrade-vmware-harbor-letencrypt-ssl-certificate-e684e08cb655