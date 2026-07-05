#!/usr/bin/env sh
command -v docker >/dev/null 2>&1 || curl -fsSL https://get.docker.com | sudo sh

sudo groupadd -f docker
sudo usermod -aG docker $USER
