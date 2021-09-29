#!/bin/bash
set -o errexit
yc compute instance create \
  --name reddit-full \
  --hostname reddit-full \
  --memory=2 \
  --create-boot-disk image-folder-id=b1gmeorbkbe3ujqhbp7d,image-family=reddit-full,size=11GB \
  --network-interface subnet-name=infra-ru-central1-a,nat-ip-version=ipv4 \
  --zone=ru-central1-a \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
