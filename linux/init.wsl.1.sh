#!/bin/bash

# make repositories dirctory

PARENT_DIR=$(cd "$(dirname "$0")"; cd ..;pwd)
IS_WSL=false
NO_NEOVIM=false
WSL_USER=""
REPO_PATH="$HOME/repos"
DOTFILES_PATH="$HOME/repos/dotfiles"

USAGE=$(
cat << EOH
Usage init.sh [--wsl <windows_username>] [<-r|--repo> <repository_path>] [<-d|--dotfiles> <dotfiles_path>] [--no-neovim]

OPTIONS:
  -r --repo:      repository path preference
                  default: ${REPO_PATH}
  -d --dotfiles:  repository path preference
                  default: ${DOTFILES_PATH}
     --wsl:       exec wsl mode
                  automatic creation symbolic links to windows fs
                      iATTENTIONS!:
                          - plz input windows username after option
     --no-neovim: no install neovim text editor
EOH
)

for opt in "$@"; do # in "$@" を省略して for opt と書くことも出来ます。
  case $opt in
    -r) REPO_PATH=$2; shift 2 ;;
    --repo) REPO_PATH=$2; shift 2 ;;
    -d) DOTFILES_PATH=$2; shift 2 ;;
    --dotfiles) DOTFILES_PATH=$2; shift 2 ;;
    --wsl) IS_WSL=true; WSL_USER=$2; shift 2 ;;
    --no-neovim) NO_NEOVIM=true; shift 1 ;;
    --) shift; break ;;
  esac
done

if [ "$IS_WSL" ] && [ "$WSL_USER" = "" ] ; then
    echo "$USAGE"
    exit 1
fi

echo "PARENT_DIR: ${PARENT_DIR}"
echo "IS_WSL: ${IS_WSL}"
echo "NO_NEOVIM: ${NO_NEOVIM}"
echo "WSL_USER: ${WSL_USER}"
echo "REPO_PATH: ${REPO_PATH}"
echo "DOTFILES_PATH: ${DOTFILES_PATH}"

if [ "$IS_WSL" ] ; then
  #ln -s "/mnt/c/Users/${WSL_USER}/bin" bin -t $HOME
  mkdir ~/bin
  ln -s "/mnt/c/Users/${WSL_USER}/repos" repos -t $HOME
  ln -s "/mnt/c/Users/${WSL_USER}" winhome -t $HOME
  ln -s "/mnt/c/Users/${WSL_USER}" home -t $HOME
  #ln -s "/mnt/c/Users/${WSL_USER}/.ssh" .ssh -t $HOME
  cp -r "/mnt/c/Users/${WSL_USER}/.ssh" ~/.ssh
  chmod -R 600 ~/.ssh

  sudo mv /etc/wsl.conf /etc/wsl.conf.old
  #sudo mv /etc/resolv.conf /etc/resolv.conf.old
  sudo mv /etc/sysctl.conf /etc/sysctl.conf.old
  #sudo mv /etc/hosts /etc/hosts.old

  sudo cp "${PARENT_DIR}/linux/wsl/wsl.conf" /etc/wsl.conf
  #sudo cp "${PARENT_DIR}/linux/wsl/resolv.conf" /etc/resolv.conf
  sudo cp "${PARENT_DIR}/linux/wsl/sysctl.conf" /etc/sysctl.conf

  #sudo cp "${PARENT_DIR}/wsl/hosts" /etc/hosts
  #sudo sh -c "cat ${PARENT_DIR}/wsl/hosts >> /etc/hosts"
  #sudo sh -c 'echo 127.0.1.1 $(hostname) >> /etc/hosts'
  #
#  if [ "$dirname" ] ; then
#    ln -s "/mnt/c/Users/${WSL_USER}/.config" .config
#  fi
else
  mkdir ~/bin
  mkdir ~/repos
  mkdir ~/.ssh
fi

echo 'export PATH=~/bin:$PATH' >> ~/.bashrc

echo 'this script has been finished'
echo 'PLZ => execute `sudo reboot` or `wsl --shutdown`, before exec `init.wsl.2.sh` ...'

# sudo reboot
