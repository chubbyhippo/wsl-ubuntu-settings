# wsl-ubuntu-settings
# init
```shell
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/init.sh | /usr/bin/env sh
```
# wsl install
```powershell
wsl --install
```
```powershell
wsl --set-default ubuntu
```
# wsl uninstall
```powershell
wsl --unregister ubuntu
```
```powershell
wsl --uninstall
```
```powershell
wsl --list
```
## check ubuntu version
```sh
lsb_release -a
```
## wsl settings install
| File | Lands at | Note |
|---|---|---|
| `wsl.conf` | `/etc/wsl.conf` | created only if absent |
| `.wslconfig` | `%UserProfile%\.wslconfig` | created only if absent |
| apply with | `wsl --shutdown` | |
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/wsl.sh | /usr/bin/env sh
```
## apt install
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/apt.sh | /usr/bin/env sh
```
## snap install
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/snap.sh | /usr/bin/env sh
```
## docker install
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/docker.sh | /usr/bin/env sh
```
## brew install (nerd font)
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/brew.sh | /usr/bin/env sh
```
## mise install (official installer + global tools from mise.toml)
```sh
curl -fsSL https://mise.run | sh
```
```sh
curl -fsSL https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu-settings/refs/heads/main/mise.toml -o ~/.config/mise/config.toml
```
```sh
mise install --yes
```
## add crt
```sh
sudo cp /mnt/c/Path/To/Your/certificate.crt /usr/local/share/ca-certificates/
```
```sh
sudo update-ca-certificates
```
