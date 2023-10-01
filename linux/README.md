# dotfiles

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

### 1. init.wsl.1.sh

初期設定です

```bash
./init.wsl.1.sh --wsl <Windows のユーザ名>
```

> `init.wsl.1.sh` を実行した後は、必ず当該の `wsl` をシャットダウンし、再度 `wsl` コマンドで起動してください
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

### 2. init.wsl.2.sh

`init.wsl.1.sh` で足りない `wsl` 向けの設定を行ってくれます

```bash
./init.wsl.2.sh
```

> `init.wsl.1.sh` を実行した後は、必ず当該の `wsl` をシャットダウンし、再度 `wsl` コマンドで起動してください
>
> ```pwsh
> PS> wsl --shutdown
> PS> wsl
> ```

### 3. init.depends.sh

`init.xxxx.sh` が依存する関係のパッケージ類を **すべて** 入れてくれます

```bash
./init.depends.sh
```

### 4. init.neovim.sh

neovim をインストールしてくれます

```bash
./init.neovim.sh
```

### 5. init.asdf.sh

`asdf` を入れてくれます

```bash
./init.asdf.sh
```

### 6. init.docker.sh

`docker` を入れてくれます

> ちょっと一部修正が必要な個所があるかもなので、その点は要注意です…

```bash
./init.docker.sh
```

### 7. init.aws.sh

`aws` 関連ツールを入れてくれます

```bash
./init.aws.sh
```

## 私向け

clone してきたときに必ずこれやれ (`.sh` が実行できなくなるので)

```bash
$ git config --local core.autocrlf false
```

## 参考

- [WSL2 に「ubuntu 20.04 LTS」をインストール後に更新できない場合](https://qiita.com/dmkd3006/items/ca6a9b34e60f9c04e361)
- [なんか WSL2 がインターネットにつながらなくなったときの解決方法](https://qiita.com/kotauchisunsun/items/71fae973afa00ebb871a)
