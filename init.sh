#!/usr/bin/env sh

sudo apt update -y
sudo DEBIAN_FRONTEND="noninteractive" apt upgrade -y

# wsl settings (wsl.conf / .wslconfig, created only if absent)
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/wsl.sh | /usr/bin/env sh
# apt
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/apt.sh | /usr/bin/env sh
# snap
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/snap.sh | /usr/bin/env sh
# docker
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/docker.sh | /usr/bin/env sh
# fzf (its installer git-clones ~/.fzf, which fails when the clone exists)
[ -d ~/.fzf ] || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/fzf/refs/heads/main/install.sh | /usr/bin/env sh
# mise
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/mise/refs/heads/main/install-bash.sh | /usr/bin/env bash
# starship
command -v starship >/dev/null 2>&1 || curl -fsSL https://starship.rs/install.sh | sh
# bashrc — append once, keyed on the gac alias ('>>' creates the file if missing)
grep -qsF 'alias gac=' ~/.bashrc || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/.bashrc >> ~/.bashrc
# trivy
command -v trivy >/dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sudo sh -s -- -b /usr/local/bin v0.70.0
# brew
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/brew.sh | /usr/bin/env sh
# init.el extras (language servers + debuggers)
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/init-el-extras.sh | /usr/bin/env sh
# ai clis (claude code, codex, gemini)
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/ai.sh | /usr/bin/env sh
