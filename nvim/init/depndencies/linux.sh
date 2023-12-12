#!/bin/bash

##### DenoLand.Deno

# 事前にunzipをインストールしておく
sudo apt install unzip
# denoをインストールする
curl -fsSL https://deno.land/x/install/install.sh | sh
# .bashrcにパスを通す
echo "export DENO_INSTALL='${HOME}/.deno'" >> ~/.bashrc
echo 'export PATH="$DENO_INSTALL/bin:$PATH"' >> ~/.bashrc



##### finish

# .bashrcを再読み込み
source ~/.bashrc

