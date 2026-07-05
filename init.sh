#!/usr/bin/env sh

sudo apt update -y
sudo DEBIAN_FRONTEND="noninteractive" apt upgrade -y

# apt
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/apt.sh | /usr/bin/env sh
# snap
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/snap.sh | /usr/bin/env sh
# docker
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/docker.sh | /usr/bin/env sh
# fzf (its installer git-clones ~/.fzf, which fails when the clone exists)
[ -d ~/.fzf ] || curl https://raw.githubusercontent.com/chubbyhippo/fzf/refs/heads/main/install.sh | /usr/bin/env sh
# mise
curl https://raw.githubusercontent.com/chubbyhippo/mise/refs/heads/main/install-bash.sh | /usr/bin/env bash
# starship
command -v starship >/dev/null 2>&1 || curl -sS https://starship.rs/install.sh | sh
# bashrc — append once, keyed on the gac alias ('>>' creates the file if missing)
grep -qsF 'alias gac=' ~/.bashrc || curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/.bashrc >> ~/.bashrc
# trivy
command -v trivy >/dev/null 2>&1 || curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.70.0
# brew
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/brew.sh | /usr/bin/env sh
# init.el extras (language servers + debuggers)
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/init-el-extras.sh | /usr/bin/env sh
