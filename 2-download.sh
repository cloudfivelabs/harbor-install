HARBOR_VERSION="v2.4.3"

## download the installer
curl -LO https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/harbor-online-installer-${HARBOR_VERSION}.tgz

## download the asc file
curl -LO https://github.com/goharbor/harbor/releases/download/${HARBOR_VERSION}/harbor-online-installer-${HARBOR_VERSION}.tgz.asc

## download Harbor key
gpg --keyserver hkps://keyserver.ubuntu.com --receive-keys 644FF454C0B4115C

## verify the key
gpg -v --keyserver hkps://keyserver.ubuntu.com --verify harbor-online-installer-${HARBOR_VERSION}.tgz.asc

## unpack the installer
tar xvf harbor-online-installer-${HARBOR_VERSION}.tgz
