# dotfiles/linux

たぶんいい感じに linux をセットアップしてくれる

今のところ `Ubuntu` のみ対応

## ファイル説明

### init.sh

初期設定

#### 使い方例

- ./init.sh --wsl <Windows のユーザ名>

#### やってくれること

- 少なくとも `.ssh` への `シンボリックリンク` は linux
  のホームディレクトリに貼ってくれます
- neovim をインストールしてくれます

#### 関連ファイル

##### wsl/etc/\*

wsl 向けの `/etc/` の初期設定が含まれています

#### オプション

##### --wsl <windows_username>

一応普通の linux でも使う想定なので、wsl モードを保有 wsl モードの場合、Windows
のファイルシステム上の設定ファイルに対してシンボリックリンクを貼ることで、ある程度の環境構築を実施する想定

こちらを指定する場合は、必ず windows 上のユーザ名を後につける必要有

> e.g. ユーザ名が `takoyaki_mantoman` の場合: `--wsl takoyaki_mantoman`

##### -r <repository_path>

あなたが使用しているリポジトリ管理ディレクトリへのシンボリックリンクを WSL2
上に貼る場合に使用する

こちらを指定する場合は、必ず windows 上のリポジトリのパスを後につける必要有

> e.g. `-r /mnt/c/Users/takoyaki_mantoman/repos`

##### -d <dotfiles_path>

あなたが使用している設定ファイル群へのシンボリックリンクを WSL2
上に貼る場合に使用する

こちらを指定する場合は、必ず windows 上のパスを後につける必要有

> e.g. `-d /mnt/c/Users/takoyaki_mantoman/repos/dotfiles`

##### --no-neovim

Neovim のインストールをスキップします

### init.asdf.sh

とりあえず `asdf` を入れてくれます

#### 使い方例

- `./init.asdf.sh`

### init.docker.sh

とりあえず `docker` を入れてくれます

#### 使い方例

- `./init.docker.sh`
