#!/bin/bash

pip install aws-mfa

# aptのリポジトリの `awscli` は v2なので、一旦削除
sudo apt remove -y awscli

# awscli v2のインストールはこの方法
# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
