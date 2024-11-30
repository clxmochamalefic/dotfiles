#!/usr/bin/env pwsh

$dotconf_path = "${HOME}\.config"
$wezterm_conf_path = "${dotconf_path}\wezterm\"

$windowsterm_conf_findpath = "${HOME}\AppData\Local\Packages\"
$packname = "Microsoft.WindowsTerminal"
$localstate = "\LocalState"

# copy wezterm settings
if (!(Test-Path $dotconf_path))
{
  mkdir $dotconf_path
  mkdir $wezterm_conf_path
}
if (!(Test-Path $wezterm_conf_path))
{
  mkdir $wezterm_conf_path
}

$setting_list = ls -Name ./wezterm/
foreach ($setting in $setting_list)
{
  echo "./wezterm/${setting}"
  cp "./wezterm/${setting}" $wezterm_conf_path
}

# copy windows terminal settings
$location_list = ls $windowsterm_conf_findpath | Select-String $packname

foreach ($location in $location_list)
{
  cp ./windowsterminal/settings.windowsterminal.json "${location}\$localstate\settings.json"
}

