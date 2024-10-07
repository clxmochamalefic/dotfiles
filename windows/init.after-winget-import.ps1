#!/usr/bin/env pwsh

Write-Output ""
Write-Output "initialize winget plugins"

Write-Output ""
Write-Output 'volta setup'
volta setup
volta completions -o ~/Documents/PowerShell/volta powershell

Write-Output ""
Write-Output 'script finished'

