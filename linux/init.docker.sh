#!/bin/bash -e

DC_VERSION=2.20.3

echo "### fetch docker-compose ###"
echo "### VERSION: ${DC_VERSION} ###"

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL "https://github.com/docker/compose/releases/download/v${DC_VERSION}/docker-compose-linux-x86_64" -o $DOCKER_CONFIG/cli-plugins/docker-compose

echo "mv: $HOME/.docker/cli-plugins/docker-compose => /usr/bin/docker-compose"

sudo mv $HOME/.docker/cli-plugins/docker-compose /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

echo "### INSTALL PATH CHECK ###"
docker compose version

echo '' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/bin' >> ~/.bashrc
echo '' >> ~/.bashrc

