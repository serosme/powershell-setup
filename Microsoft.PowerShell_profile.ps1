function Prompt {
    Write-Host ">" -NoNewline -ForegroundColor White
    return " "
}

function Open-Startup {
    Start-Process "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
}

function Update-All {
    Update-Scoop
    Update-Winget
}

function Update-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Warning "winget not found, skipping Winget update"
        return
    }
    winget update --all
}

function Update-Scoop {
    if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Warning "scoop not found, skipping Scoop update"
        return
    }
    scoop update
    scoop update *
    scoop cleanup *
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

function z {
    if ($args.Count -eq 0) {
        Set-Location $env:USERPROFILE\workspace
    }
    else {
        $target = $args[0].Trim()
        if (-not $target) {
            Set-Location $env:USERPROFILE\workspace
        }
        elseif (Test-Path $target -PathType Container) {
            Set-Location $target
        }
        else {
            Write-Warning "Directory not found: $target"
        }
    }
}

function gb {
    param(
        [string]$Path = ""
    )
    $target = $Path.Trim()
    if (-not $target) {
        $target = $pwd
    }
    if (Test-Path $target -PathType Container) {
        wt -w 0 -p "Git Bash" -d "$target"
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "wt exited with code $LASTEXITCODE for: $target"
        }
    }
    else {
        Write-Warning "Directory not found: $target"
    }
}

function e {
    if ($args.Count -eq 0) {
        Invoke-Item $env:USERPROFILE\workspace
    }
    else {
        $target = $args[0].Trim()
        if (-not $target) {
            Invoke-Item $env:USERPROFILE\workspace
        }
        elseif (Test-Path $target) {
            Invoke-Item $target
        }
        else {
            Write-Warning "Path not found: $target"
        }
    }
}

function uwsl {
    $Name = 'Debian'
    $User = 'debian'
    $Pass = 'debian'

    $i = 0
    while ($i -lt $args.Count) {
        switch ($args[$i]) {
            '--name' { $Name = $args[++$i] }
            '--user' { $User = $args[++$i] }
            '--pass' { $Pass = $args[++$i] }
        }
        $i++
    }

    $f = New-TemporaryFile
    [IO.File]::WriteAllText($f, "$User`n$Pass`n$Pass`n")
    cmd /c "wsl.exe --install --name $Name -d Debian < ""$f"" 2>&1"
    Remove-Item $f
}
