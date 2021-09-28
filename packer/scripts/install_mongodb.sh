#!/bin/bash
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 656408E390CFB1F5
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb.list
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq
wait
apt-get install -y mongodb-org
systemctl enable --now mongod
