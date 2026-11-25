#!/usr/bin/env sh

sudo apt update -y
sudo DEBIAN_FRONTEND="noninteractive" apt upgrade -y

# apt
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/apt.sh | /usr/bin/env sh
# snap
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/snap.sh | /usr/bin/env sh
# docker
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/docker.sh | /usr/bin/env sh
# mise (official installer; .bashrc below activates it) + the global tool
# set from mise.toml. Erlang compiles from source, so its OTP build deps
# come first (minimal headless set — for the GUI observer/debugger add
# libwxgtk3.2-dev libgl1-mesa-dev).
[ -x ~/.local/bin/mise ] || curl -fsSL https://mise.run | sh
mkdir -p ~/.config/mise
[ -f ~/.config/mise/config.toml ] || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/mise.toml -o ~/.config/mise/config.toml
sudo apt install -y autoconf m4 libncurses-dev libssl-dev
~/.local/bin/mise install --yes
# starship
command -v starship >/dev/null 2>&1 || curl -fsSL https://starship.rs/install.sh | sh
# bashrc — append once, keyed on the gac alias ('>>' creates the file if missing)
grep -qsF 'alias gac=' ~/.bashrc || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/.bashrc >> ~/.bashrc
# brew
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/brew.sh | /usr/bin/env sh
