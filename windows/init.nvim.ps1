#install python3
choco install -y python3
choco install -y nodejs
$path = [System.Environment]::GetEnvironmentVariable("Path", "User")
$path += ";C:\Python39;C:\Program Files\Git\bin"
[System.Environment]::SetEnvironmentVariable("Path", $path, "User")

# install neovim
choco install -y neovim

# install pip
cd C:\Python39
wget "https://bootstrap.pypa.io/get-pip.py" -O "get-pip.py"
.\get-pip.py
pip install neovim

# dotfiles
mkdir $1 + "\repos"
cd $1 + "\repos"
git clone https://github.com/cocoalix/dotfiles

cp C:\Users\nao_akakura\repos\dotfiles\vim\init.vim.windows-first C:\Users\nao_akakura\AppData\Local\nvim\init.vim
cp C:\Users\nao_akakura\repos\dotfiles\vim\init.vim C:\Users\nao_akakura\AppData\Local\nvim\init.vim.second
cp C:\Users\nao_akakura\repos\dotfiles\vim\*.toml C:\Users\nao_akakura\AppData\Local\nvim\

# Enable WSL2
dism.exe /online /enable-features /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

cd $1 + "\Downloads"
wget "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -0 "wsl_update_x64.msi"
wsl --set-default-version 2