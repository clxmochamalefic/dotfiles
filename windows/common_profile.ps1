function nq() { nvim-qt ~ }
function ssho() { ssh -o ServerAliveInterval=60 $args }
function which() { Get-Command $args | Format-List }
function sh() { pwsh $args }

Import-Module posh-git
oh-my-posh init pwsh --config $env:POSH_THEMES_PATH/paradox.omp.json | Invoke-Expression
