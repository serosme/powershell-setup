$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

function Update-All {
    Update-Scoop
    Update-Winget
    Update-Pnpm
}

function Update-Winget {
    winget update --all
}

function Update-Scoop {
    scoop update
    scoop update *
    scoop cleanup *
}

function Update-Pnpm {
    pnpm update -g
}

function Set-Shell-Proxy {
    $env:http_proxy = "http://127.0.0.1:7890";
    $env:https_proxy = "http://127.0.0.1:7890";
}

function Set-Git-Proxy {
    git config --global http.proxy http://127.0.0.1:7890
    git config --global https.proxy http://127.0.0.1:7890
}

function Reset-Git-Proxy {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

function Set-Scoop-Proxy {
    scoop config proxy 127.0.0.1:7890
}

function Reset-Scoop-Proxy {
    scoop config rm proxy
}

function Set-WinGet-Proxy {
    sudo winget settings set DefaultProxy http://127.0.0.1:7890
}

function Reset-WinGet-Proxy {
    sudo winget settings reset DefaultProxy
}

function Set-All-Proxy {
    Set-Git-Proxy
    Set-Scoop-Proxy
    Set-WinGet-Proxy
}

function Reset-All-Proxy {
    Reset-Git-Proxy
    Reset-Scoop-Proxy
    Reset-WinGet-Proxy
}

function Enable-Long-Path-Support {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord -Force
}

function Reset-Notify {
    Remove-Item -Path "HKCU:\Control Panel\NotifyIconSettings" -Recurse
    Stop-Process -Name explorer
}

function Set-Old-Context-Menu {
    $clsidPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
    New-Item -Path $clsidPath -Force
    New-ItemProperty -Path $clsidPath -Name "(default)" -Value "" -PropertyType String -Force
    Stop-Process -Name explorer
}

function Set-New-Context-Menu {
    Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Recurse
    Stop-Process -Name explorer
}

function Mount-OneDrive {
    rclone mount OneDrive: O: --vfs-cache-mode full -v
}

function Mount-OneDrive_Crypt {
    rclone mount OneDrive_Crypt: P: --vfs-cache-mode full -v
}

function Mount-AList {
    rclone mount AList: Q: --vfs-cache-mode full -v
}

Import-Module PSReadLine
Import-Module posh-git

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

oh-my-posh init pwsh --config ~/workspace/private/oh-my-posh-custom/sample.omp.json  | Invoke-Expression
