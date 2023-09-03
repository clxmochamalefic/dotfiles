#!/bin/bash

sudo apt install -y make
sudo apt install -y zliblg-dev
sudo apt install -y libyaml-dev
sudo apt install -y gnome-keyring

sudo apt install -y dbus-user-session
sudo apt install -y docker-ce-rootless-extras
sudo apt install -y uidmap
sudo apt install -y uidmap fuse-overlayfs
sudo apt install libsecret-1-0

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
docker -v

# docker rootless
curl -fsSL https://get.docker.com/rootless | sh

sudo systemctl disable --now docker.service docker.socket

dockerd-rootless-setuptool.sh install --skip-iptables

# TODO: erase `--skip-iptables` by sed
vim ~/.config/systemd/user/docker.service

systemctl --user daemon-reload
systemctl --user restart docker

sudo setcap cap_net_bind_service=ep /home/cocoalix/bin/rootlesskit
