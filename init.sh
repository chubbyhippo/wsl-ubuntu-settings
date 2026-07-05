#!/usr/bin/env sh

sudo apt update -y
sudo DEBIAN_FRONTEND="noninteractive" apt upgrade -y

# apt
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/apt.sh | /usr/bin/env sh
# snap
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/snap.sh | /usr/bin/env sh
# docker
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/docker.sh | /usr/bin/env sh
# fzf
curl https://raw.githubusercontent.com/chubbyhippo/fzf/refs/heads/main/install.sh | /usr/bin/env sh
# mise
curl https://raw.githubusercontent.com/chubbyhippo/mise/refs/heads/main/install-bash.sh | /usr/bin/env bash
# starship
curl -sS https://starship.rs/install.sh | sh
# bashrc
[ -f ~/.bashrc ] && curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu/main/.bashrc >> ~/.bashrc || curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu/main/.bashrc -o ~/.bashrc
# trivy
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.70.0
# brew
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/brew.sh | /usr/bin/env sh
# init.el extras (language servers + debuggers)
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/init-el-extras.sh | /usr/bin/env sh
