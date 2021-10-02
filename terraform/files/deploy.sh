#!/bin/bash
set -e
git clone -b monolith https://github.com/express42/reddit.git ${1:-$HOME}/reddit
cd ${1:-$HOME}/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl daemon-reload
sudo systemctl enable --now puma.service

