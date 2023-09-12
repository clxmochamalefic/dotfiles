# dotfiles/linux

たぶんいい感じに linux をセットアップしてくれる

今のところ `Ubuntu` のみ対応

## 前提

### WSL2 で実行する場合

事前に HOST(Windows/Powershell) で以下を実行する必要がおそらく有り

```pwsh
PS> Get-NetIPInterface -InterfaceAlias "vEthernet (WSL)" | Set-NetIPInterface -InterfaceMetric 1
PS> Get-NetAdapter | Where-Object {$_.InterfaceDescription -Match "Cisco AnyConnect"} | Set-NetIPInterface -InterfaceMetric 6000
```

## ファイル説明

### 1. init.wsl.sh

初期設定

- 少なくとも `.ssh` への `シンボリックリンク` は linux
  のホームディレクトリに貼ってくれます
- また、 /etc/\* の必要なものを展開してくれます

```bash
./init.wsl.sh --wsl <Windows のユーザ名>
```

> `init.wsl.sh` を実行した後は、必ず当該の `wsl` をシャットダウンし、再度 `wsl` コマンドで起動してください
>
> ```pwsh
> PS> wsl --shutdown
> PS> wsl
> ```

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

### 2. init.depends.sh

`init.xxxx.sh` が依存する関係のパッケージ類を入れてくれます

```bash
./init.depends.sh
```

### 3. init.neovim.sh

neovim をインストールしてくれます

```bash
./init.neovim.sh
```

### 4. init.asdf.sh

とりあえず `asdf` を入れてくれます

```bash
./init.asdf.sh
```

### 5. init.docker.sh

とりあえず `docker` を入れてくれます

```bash
./init.docker.sh
```

## 私向け

clone してきたときに必ずこれやれ (`.sh` が実行できなくなるので)

```bash
$ git config --local core.autocrlf false
```

## 参考

- [WSL2 に「ubuntu 20.04 LTS」をインストール後に更新できない場合](https://qiita.com/dmkd3006/items/ca6a9b34e60f9c04e361)
- [なんか WSL2 がインターネットにつながらなくなったときの解決方法](https://qiita.com/kotauchisunsun/items/71fae973afa00ebb871a)
