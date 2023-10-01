#!/bin/bash

echo ""
echo "exec => init.depends.sh"

echo ""
echo '    apt update'
sudo apt update

echo ""
echo '    apt install basic packages 1of2'
sudo apt install -y make build-essential libssl-dev libyaml-dev

echo ""
echo '    apt install basic packages 2of2'
sudo apt install -y zlib1g-dev gnome-keyring dirmngr gpg curl gawk zip jq curl git

# install FUSE
echo ""
echo '    apt install FUSE'
sudo add-apt-repository -y universe
sudo apt install -y libfuse2 xvfb libgtk2.0-0 libnotify-dev libgconf-2-4 libnss3 libxss1 libasound2 libgbm-dev

# docker
echo ""
echo '    apt install dbus-user-session'
sudo apt install -y dbus-user-session
#sudo apt install -y docker-ce-rootless-extras
echo ""
echo '    apt install uidmap fuse-overlayfs libsecret-1-0'
sudo apt install -y uidmap fuse-overlayfs libsecret-1-0

echo ""
echo '    apt install docker-ce containerd docker-compose-plugin'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo ""
echo 'finished script'
echo ""
