#install python3 & nodejs
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

# dein.vim
Invoke-WebRequest https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.ps1 -OutFile installer.ps1
# Allow to run third-party script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# For example, we just use `~/.cache/dein` as installation directory
./installer.ps1 ~/.cache/dein
