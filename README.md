# powershell-setup

## 软链接

```pwsh
New-Item -Path "C:\Users\User\Documents\WindowsPowerShell" -ItemType Directory -Force

New-Item -Path "C:\Users\User\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Target "C:\Users\User\workspace\personal\powershell-setup\Microsoft.PowerShell_profile.ps1"
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

## 命令

查看已安装的 PowerShell 模块

```pwsh
Get-InstalledModule
```

卸载指定模块

```pwsh
Uninstall-Module -Name <模块名>
```
