#!/bin/bash

docker -v

sudo systemctl disable --now docker.service docker.socket

# docker rootless
curl -fsSL https://get.docker.com/rootless | sh
dockerd-rootless-setuptool.sh install --skip-iptables

## rootless preference modify (erase `--iptables=false`)
sudo cp ~/.config/systemd/user/docker.service ~/.config/systemd/user/docker.service.old
sudo sed -i -e 's/--iptables=false//g' ~/.config/systemd/user/docker.service ~/.config/systemd/user/docker.service

# restart docker daemon
sudo systemctl --user daemon-reload
sudo systemctl --user restart docker

sudo setcap cap_net_bind_service=ep $HOME/bin/rootlesskit

echo 'export DOCKER_HOST=unix:///mnt/wslg/runtime-dir/docker.sock' >> ~/.bashrc
