# Neovim installation-guide

## create referenceable preference file for windows10 and later versions

plz exec it

```pwsh
PS> .\win.init.ps1
```

## get python3

### Windows

1. `winget install Python.Python.3.10`

2. exec this
  ```pwsh
  PS> pip install pynvim
  ```

### Mac

1. exec this

```zsh
brew install pyenv
brew install pyenv-virtualenv
```

2. write `.zprofile`

```.zprofile
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

3. exec this

```zsh
# check installable python version
pyenv install --list
# check installed python version
pyenv versions

# create python2 env (choose newer version)
pyenv install 2.7.15
pyenv virtualenv 2.7.15 neovim2
pyenv activate neovim2
pip2 install neovim
pyenv which python

# create python3 env (choose newer version)
pyenv install 3.5.3
pyenv virtualenv 3.5.3 neovim3
pyenv activate neovim3
pip install neovim
pyenv which python
```

## get neovim

### Windows

```pwsh
PS> winget install Neovim.Neovim
```

if u need nightly build

```pwsh
PS> winget install Neovim.Neovim.Nightly
```

### Mac

```zsh
% brew install neovim
```

## attach my init.vim

### Windows

```pwsh
PS> mkdir -p ~/AppData/Local/nvim
PS> cp ./init.vim ~/AppData/Local/nvim/init.vim
PS> cp ./*.vim ~/AppData/Local/nvim/
```

### Mac

```zsh
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim
cp ./*.vim ~/.config/nvim/
```

## REPLACE g:python3_host_prog

1. exec `:checkhealth` on nvim

2. copy `INFO: Executable:` row in  `Python 3 provider`

3. paste to `g:python3_host_prog`

4. exec `:echo has('python3')` on nvim for check useable python3

## exec nvim

1. auto install dein and plugins
