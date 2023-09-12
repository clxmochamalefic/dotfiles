#!/bin/bash

sudo apt update

sudo apt install -y make
sudo apt install -y build-essential
sudo apt install -y libssl-dev
sudo apt install -y libyaml-dev
sudo apt install -y zlib1g-dev
sudo apt install -y gnome-keyring
sudo apt install -y dirmngr gpg curl gawk
sudo apt install -y zip
sudo apt install -y jq

sudo apt install -y curl
sudo apt install -y git

# install FUSE
sudo add-apt-repository universe
sudo apt install -y libfuse2

# docker
sudo apt install -y dbus-user-session
#sudo apt install -y docker-ce-rootless-extras
sudo apt install -y uidmap fuse-overlayfs
sudo apt install -y libsecret-1-0
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
