# Enable WSL2
dism.exe /online /enable-features /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

cd $1 + "\Downloads"
wget "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -O "wsl_update_x64.msi"
wsl --set-default-version 2