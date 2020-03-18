# Neovim installation-guide

## 1. get python3

### Windows

1. get from [official](https://www.python.org/)

1. exec this
  ```bash
  pip install pynvim
  ```

### Mac


## 2. get neovim

### Windows

get from [official](https://github.com/neovim/neovim/releases)

### Mac

```zsh
$ brew install neovim
```

## 3. attach my init.vim

### Windows

```bash
mkdir -p ~/AppData/Local/nvim
cp ./init.vim ~/AppData/Local/nvim/init.vim
cp ./*.vim ~/AppData/Local/nvim/
```

### Mac

```bash
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim
cp ./*.vim ~/.config/nvim/
```

## 4. REPLACE g:python3_host_prog

1. exec `:checkhealth` on nvim

1. copy `INFO: Executable:` row in  `Python 3 provider`

1. paste `g:python3_host_prog`

1. exec `:echo has('python3')` on nvim for check useable python3

## 5. exec nvim

1. auto install dein and plugins
