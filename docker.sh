#!/usr/bin/env sh
curl -fsSL https://get.docker.com | sudo sh

sudo groupadd docker
sudo usermod -aG docker $USER
