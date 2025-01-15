# import packages for winget and windows11

## HOW to USE

```pwsh
cd ./<any directory>
ls -Name | %{ winget import --accept-package-agreements --accept-source-agreements -i  $_ }
```

or

```pwsh
ls ./common/ -Name | %{ winget import --accept-package-agreements --accept-source-agreements -i  $_ }
ls ./dev/ -Name | %{ winget import --accept-package-agreements --accept-source-agreements -i  $_ }
ls ./private/ -Name | %{ winget import --accept-package-agreements --accept-source-agreements -i  $_ }
```
