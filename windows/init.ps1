#install python3
choco install -y python3
choco install -y nodejs
$Env:Path += ";C:\Python39\python.exe"

# install neovim
choco install -y neovim

# install pip
cd C:\Python39
wget "https://bootstrap.pypa.io/get-pip.py" -0 "get-pip.py"
.\get-pip.py
pip install neovim

# dotfiles
mkdir $1 + "\repos"
cd $1 + "\repos"
git clone https://github.com/cocoalix/dotfiles

# Enable WSL2
dism.exe /online /enable-features /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

cd $1 + "\Downloads"
wget "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -0 "wsl_update_x64.msi"
wsl --set-default-version 2