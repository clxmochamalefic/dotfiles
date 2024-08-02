
function nq()
{
  nvim-qt ~ 
}

# gui neovim
function gn()
{
  # TODO: gcmでgui-nvimを探す処理が別途必要のはず
  neovide ~ 
}

function ssho()
{
  ssh -o ServerAliveInterval=60 $args 
}

function which()
{
  Get-Command $args | Format-List 
}

function where()
{
  gcm $args
}

function sh()
{
  pwsh $args 
}

# denops server up
function denopsup()
{
  $startupPath = [Environment]::GetEnvironmentVariable('Startup', 'USER')
  $denopsVbsPath = "${startupPath}\boot_denops.vbs"
  Start-Process $denopsVbsPath
}

# denops server up
function deup()
{
  denopsup
}


function reload()
{
  Write-Output 'RELOAD profile'
    . $PROFILE
}

