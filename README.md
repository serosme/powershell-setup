# powershell-setup

## 软链接

```pwsh
New-Item -Path C:\Users\User\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -ItemType SymbolicLink -Target C:\Users\User\workspace\personal\powershell-setup\Microsoft.PowerShell_profile.ps1
```

## 取消提示

```pwsh
powershell -nologo
```

## PowerShell

PSReadLine

```pwsh
Install-Module -Name PSReadLine -Scope CurrentUser -Force
```

posh-git

```pwsh
Install-Module -Name posh-git -Scope CurrentUser -Force
```
