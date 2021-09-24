#!/bin/bash
set -o errexit
sudo apt-get install git
git clone https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
exit 0
