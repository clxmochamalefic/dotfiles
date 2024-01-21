#!/bin/bash

# ===== PREPARE =====
CURRENT=$(pwd)

# install font-forge
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:fontforge/fontforge
sudo apt update;
sudo apt install -y fontforge

FONTS_DIR=/usr/local/share/fonts/

# create font dir
sudo mkdir $FONTS_DIR
# update fonts-conf cache
fc-cache $FONTS_DIR

# create font files download dir
mkdir $HOME/temp
mkdir $HOME/temp/fonts

# clone nerd-fonts
cd $HOME/temp
git clone https://github.com/ryanoasis/nerd-fonts.git
PATH=$PATH:$HOME/temp/nerd-fonts # temporary executable

# ===== INSTALL FONTS =====
cd $HOME/temp/fonts

# ----- INTEL ONE MONO -----
# get intel one mono with NERD font
curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/IntelOneMono.tar.xz -o IntelOneMono.tar.xz
# extract
tar -xJvf ./IntelOneMono.tar.xz --one-top-level
# move to fonts dir
sudo mv ./IntelOneMono/*.ttf $FONTS_DIR

# ----- CICA -----
curl -L https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3.zip -o Cica.zip
unzip ./Cica.zip -d Cica
sudo mv ./Cica/*.ttf $FONTS_DIR

# ----- HACK -----
curl -L https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-webfonts.tar.xz -o Hack.tar.xz
tar -xJvf ./Hack.tar.xz --one-top-level
sudo mv ./Hack/*.ttf $FONTS_DIR

# ===== RELEASE TEMP DIR =====
cd $HOME/temp
rm -rf ./fonts

cd $CURRENT
