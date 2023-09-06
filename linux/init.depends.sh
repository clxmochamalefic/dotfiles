#!/bin/bash

apt update

apt install -y make
apt install -y build-essential
apt install -y libssl-dev
apt install -y libyaml-dev
apt install -y zlib1g-dev
apt install -y gnome-keyring
apt install -y uidmap fuse-overlayfs
apt install -y dirmngr gpg curl gawk
