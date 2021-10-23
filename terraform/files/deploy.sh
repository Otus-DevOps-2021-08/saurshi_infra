#!/bin/bash
set -e
DBURL=$(cat < /tmp/dburl.txt)
git clone -b monolith https://github.com/express42/reddit.git ${1:-$HOME}/reddit
cd ${1:-$HOME}/reddit
sed -i "s/127.0.0.1/$DBURL/g" app.rb
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable --now puma.service

