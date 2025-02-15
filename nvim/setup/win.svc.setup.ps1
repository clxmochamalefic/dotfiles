#!/usr/bin/env pwsh

$depends = "${PSScriptRoot}\dependencies\boot_denops.ps1"

#$denopsCmd = "deno run -A --no-lock $HOME/AppData/Local/nvim-data/lazy/denops.vim/denops/@denops-private/cli.ts --hostname=0.0.0.0 --port 33576"

New-Service -Name DenopsServer -BinaryPathName $depends -DisplayName "denops-server" -StartupType "Automatic"

Start-Service DenopsServer
