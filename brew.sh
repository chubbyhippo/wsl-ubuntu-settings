#!/usr/bin/env bash

[ -x /home/linuxbrew/.linuxbrew/bin/brew ] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

grep -qsF 'brew shellenv' "$HOME/.bashrc" || echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> "$HOME/.bashrc"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

brew list --cask font-jetbrains-mono-nerd-font >/dev/null 2>&1 || brew install --cask font-jetbrains-mono-nerd-font
