# dotfiles/windows

preference and depend package for windows by me

## iii ATTENTIONS !!!

### Linux env initialize (on WSL2)

INJECTED: to --> ../linux/README.md

## dirs

### bin

windows scripts made by me

### preferences

my preferences included

## scripts (ps1 / sh)

### init.ps1

initialize this windows USER env

copy my-default pwsh profile to this windows USER env

### init.after.winget.ps1

update winget installed package settings

### init.wsl2.ps1

enable WSL2 and install Ubuntu-22.04 LTS in WSL2

### upgrade.to.wsl2.ps1

initialize (or upgrade) to WSL2 script on PowerShell (pwsh) for WSL1 pre-installed enviroment

## zip

### Files_2.5.21.0.zip

default preference for `Files` (filesystem viewer) 

## json

### settings.windowsterminal.json

preference for WindowsTerminal

### winget.install.<name>.json

dependencies list for winget

USAGE is below

```pwsh
winget import winget.install.<name>.json --disable-interactivity --ignore-unavailable --ignore-versions --no-upgrade --accept-package-agreements --accept-source-agreements 
```

#### winget.install.common.json

common application list

```pwsh
winget import winget.install.common.json --disable-interactivity --ignore-unavailable --ignore-versions --no-upgrade --accept-package-agreements --accept-source-agreements 
```

#### winget.install.dev.json

common development depend application list

```pwsh
winget import winget.install.dev.json --disable-interactivity --ignore-unavailable --ignore-versions --no-upgrade --accept-package-agreements --accept-source-agreements 
```

#### winget.install.private.json

private application list

```pwsh
winget import winget.install.private.json --disable-interactivity --ignore-unavailable --ignore-versions --no-upgrade --accept-package-agreements --accept-source-agreements 
```

#### winget.install.work.json

work application list

```pwsh
winget import winget.install.work.json --disable-interactivity --ignore-unavailable --ignore-versions --no-upgrade --accept-package-agreements --accept-source-agreements 
```

