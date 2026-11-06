# powershell-setup

## Symlinks

Create the `WindowsPowerShell` folder if it doesn't exist:

```pwsh
New-Item -Path "$HOME\Documents\WindowsPowerShell" -ItemType Directory -Force
```

Link the profile script:

```pwsh
New-Item -Path "$HOME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" `
  -ItemType SymbolicLink `
  -Target "$HOME\workspace\powershell-setup\Microsoft.PowerShell_profile.ps1" `
  -Force
```

## PowerShell

Hide the copyright banner on startup with `-NoLogo`.
