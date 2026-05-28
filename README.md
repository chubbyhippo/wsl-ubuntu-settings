# wsl-ubuntu
# init
```shell
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu/refs/heads/main/init.sh | /usr/bin/env sh
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
## fix slow sudo apt update, change http to https
```sh
sudo nano /etc/apt/sources.list.d/ubuntu.sources
```
## check ubuntu version
```sh
lsb_release -a
```
## docker install
```sh
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu/refs/heads/main/docker.sh | /usr/bin/env sh
```
## mise install
```sh
curl https://raw.githubusercontent.com/chubbyhippo/wsl-ubuntu/refs/heads/main/mise.sh | /usr/bin/env sh
```
## add crt
```sh
sudo cp /mnt/c/Path/To/Your/certificate.crt /usr/local/share/ca-certificates/
```
```sh
sudo update-ca-certificates
```
