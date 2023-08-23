#!/bin/bash
# make repositories dirctory

PARENT_DIR=$(cd $(dirname $0); cd ..;pwd)
IS_WSL=false
WSL_USER=""
REPO_PATH="~/repos"
DOTFILES_PATH="~/repos/dotfiles"

USAGE=$(
cat << EOH
Usage init.sh [--wsl <windows_username>] [<-r|--repo> <repository_path>] [<-d|--dotfiles> <dotfiles_path>]

OPTIONS:
  -r --repo:     repository path preference
                 default: ${REPO_PATH}
  -d --dotfiles: repository path preference
                 default: ${DOTFILES_PATH}
     --wsl:      exec wsl mode
                 automatic creation symbolic links to windows fs
                     iATTENTIONS!:
                       - plz input windows username after option

EOH
)

for opt in "$@"; do # in "$@" を省略して for opt と書くことも出来ます。
  case $opt in
    -r) REPO_PATH=$2 shift 2 ;;
    --repo) REPO_PATH=$2 shift 2 ;;
    --wsl) IS_WSL=true; WSL_USER=$2 shift 2 ;;
    --) shift; break ;;
  esac
done

if [ $IS_WSL ] && [ $WSL_USER = "" ] ; then
    echo $USAGE
    exit 1
fi

if [ $IS_WSL ] ; then
  cd ~
  ln -s "/mnt/c/Users/${WSL_USER}/bin" bin
  ln -s "/mnt/c/Users/${WSL_USER}/repos" repos
  ln -s "/mnt/c/Users/${WSL_USER}/.ssh" .ssh
else
  cd ~
  mkdir ~/bin
  mkdir ~/repos
  mkdir ~/.ssh
fi

mkdir ~/appimg
mkdir ~/.config


# install FUSE

sudo add-apt-repository universe
sudo apt install libfuse2


# install neovim

cd ~/appimg
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

cd ~/bin
ln -s ~/appimg/nvim.appimage nvim

# setup neovim preference

cd ~/.config
ln -s "${DOTFILES_PATH}/nvim/" nvim

