#!/usr/bin/env sh

# Both files are created only when absent, so existing settings are never
# clobbered. Apply afterwards with: wsl --shutdown (from Windows).

# /etc/wsl.conf — per-distro settings (systemd on)
[ -f /etc/wsl.conf ] || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/wsl.conf | sudo tee /etc/wsl.conf >/dev/null

# %UserProfile%\.wslconfig — Windows-side WSL2 settings (commented examples)
WIN_HOME=$(wslpath "$(cmd.exe /c 'echo %UserProfile%' 2>/dev/null | tr -d '\r')")
[ -f "$WIN_HOME/.wslconfig" ] || curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/.wslconfig -o "$WIN_HOME/.wslconfig"
