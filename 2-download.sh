VERSION="harbor-online-installer-v2.0.1.tgz"

## download the installer
curl -LO https://github.com/goharbor/harbor/releases/download/v2.0.1/$VERSION

## download the asc file
curl -LO https://github.com/goharbor/harbor/releases/download/v2.0.1/$VERSION.asc

## download Harbor key
gpg --keyserver hkps://keyserver.ubuntu.com --receive-keys 644FF454C0B4115C

## verify the key
gpg -v --keyserver hkps://keyserver.ubuntu.com --verify $VERSION.asc

## unpack the installer
tar xvf $VERSION 
