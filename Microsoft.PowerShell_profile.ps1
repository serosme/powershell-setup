$OutputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::InputEncoding = [System.Text.UTF8Encoding]::new()
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

function Open-Startup {
    Start-Process "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
}

function Update-All {
    Update-Scoop
    Update-Winget
}

function Update-Winget {
    winget update --all
}

function Update-Scoop {
    scoop update
    scoop update *
    scoop cleanup *
}

function Set-Shell-Proxy {
    $env:http_proxy = "http://127.0.0.1:7890";
    $env:https_proxy = "http://127.0.0.1:7890";
}

function Reset-Shell-Proxy {
    $env:http_proxy = "";
    $env:https_proxy = "";
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
    Set-Shell-Proxy
    Set-Git-Proxy
    Set-Scoop-Proxy
    Set-WinGet-Proxy
}

function Reset-All-Proxy {
    Set-Shell-Proxy
    Reset-Git-Proxy
    Reset-Scoop-Proxy
    Reset-WinGet-Proxy
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

# Import-Module PSReadLine
# Import-Module posh-git

# Set-PSReadLineOption -PredictionSource History
# Set-PSReadLineOption -HistorySearchCursorMovesToEnd
# Set-PSReadlineKeyHandler -Chord Tab -Function MenuComplete
# Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# oh-my-posh init pwsh --config ~/Documents/WindowsPowerShell/sample.omp.json  | Invoke-Expression
