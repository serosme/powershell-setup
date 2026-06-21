# powershell-setup

## 软链接

```pwsh
New-Item -Path "C:\Users\User\Documents\WindowsPowerShell" -ItemType Directory -Force

New-Item -Path "C:\Users\User\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Target "C:\Users\User\workspace\powershell-setup\Microsoft.PowerShell_profile.ps1" -Force
```

## PowerShell

启动时隐藏版权横幅 `-NoLogo`
