#Requires -Version 5.1
$ErrorActionPreference = "Stop"

try {
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$host.UI.RawUI.WindowTitle = "ZYIN SCINDICATE v3.0 - LIVE TERMINAL"
$host.UI.RawUI.BackgroundColor = "Black"
$host.UI.RawUI.ForegroundColor = "Green"
Clear-Host

function Show-Boot {
    Clear-Host
    $colors = @("Red","Yellow","DarkYellow","Cyan","Magenta","Green","White")
    for ($i=0; $i -lt 7; $i++) {
        Write-Host ("#" * 100) -ForegroundColor $colors[$i]
    }
    Write-Host ""
    Write-Host "  ZYIN SCINDICATE TERMINAL" -ForegroundColor Red
    Write-Host "  [ PROTOCOL: SCINDICATE ]  [ BUILD: v3.0-LIVE ]  [ STATUS: ARMED ]" -ForegroundColor Green
    Write-Host ""
    
    $bootmsgs = @(
        "[ SYSTEM ] Initializing core modules...",
        "[ SYSTEM ] Loading exploit database...",
        "[ SYSTEM ] Connecting to anonymous proxy chain...",
        "[ SYSTEM ] Masking origin fingerprint...",
        "[ SYSTEM ] Binding to localhost adapter..."
    )
    foreach ($msg in $bootmsgs) {
        Write-Host "  $msg" -ForegroundColor DarkGray
        Start-Sleep -Milliseconds 600
    }
    Write-Host "  [ SYSTEM ] READY." -ForegroundColor Green
    Write-Host ""
    Write-Host "  Type /h for available commands." -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Help {
    Write-Host ""
    Write-Host "  === ZYIN SCINDICATE COMMAND LIST ===" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  deface (target)          - Initiate deface sequence" -ForegroundColor Yellow
    Write-Host "  scan   (target)          - Port scan target" -ForegroundColor Yellow
    Write-Host "  inject (file) (payload)  - Inject payload into file" -ForegroundColor Yellow
    Write-Host "  /h                       - Show this help menu" -ForegroundColor Yellow
    Write-Host "  exit / quit              - Terminate session" -ForegroundColor Yellow
    Write-Host "  clear / cls              - Clear terminal screen" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  USAGE: deface localhost" -ForegroundColor DarkGray
    Write-Host ""
}

function Invoke-DramaticLoad {
    param([string]$Target)
    
    $phases = @(
        "PHASE 1|Resolving DNS...|Red",
        "PHASE 2|Port scanning common vectors...|DarkRed",
        "PHASE 3|Fingerprinting server...|Yellow",
        "PHASE 4|Enumerating directories...|DarkYellow",
        "PHASE 5|Exploit matching...|Cyan",
        "PHASE 6|Injecting payload...|Magenta",
        "PHASE 7|Bypassing authentication...|Red",
        "PHASE 8|Uploading template...|Yellow",
        "PHASE 9|Overwriting index...|Green",
        "PHASE 10|Cleaning tracks...|Cyan",
        "PHASE 11|Establishing backdoor...|Magenta",
        "PHASE 12|Finalizing...|Yellow"
    )
    
    foreach ($phase in $phases) {
        $parts = $phase -split "\|"
        $name = $parts[0]
        $desc = $parts[1]
        $color = $parts[2]
        
        Write-Host "  [ $name ] $desc" -ForegroundColor $color
        Start-Sleep -Milliseconds 150
        
        if ($name -eq "PHASE 2") {
            for ($p=0; $p -lt 8; $p++) {
                $port = Get-Random -Minimum 1 -Maximum 65535
                Write-Host "  [ PHASE 2 ] Checking port $port... OPEN" -ForegroundColor (Get-Random @("Red","Yellow","Green","Cyan"))
                Start-Sleep -Milliseconds 200
            }
        }
        elseif ($name -eq "PHASE 4") {
            $dirs = @("admin","config","backup","uploads","wp-content","includes","images","cgi-bin",".env",".git")
            foreach ($dir in $dirs) {
                Write-Host "  [ PHASE 4 ] /$dir/ ... EXPOSED" -ForegroundColor (Get-Random @("Red","Yellow","Green"))
                Start-Sleep -Milliseconds 150
            }
        }
        elseif ($name -eq "PHASE 5") {
            Write-Host "  [ PHASE 5 ] CVE-2019-XXXX matched | Severity: CRITICAL" -ForegroundColor Red
            Write-Host "  [ PHASE 5 ] CVE-2021-XXXX matched | Severity: HIGH" -ForegroundColor DarkRed
            Start-Sleep -Milliseconds 300
        }
        elseif ($name -eq "PHASE 6") {
            for ($i=0; $i -lt 20; $i++) {
                $hex = "0x{0:X2}" -f (Get-Random -Maximum 255)
                Write-Host "  [ INJECT ] $hex >>> $Target" -ForegroundColor (Get-Random @("Red","Yellow","Green","Cyan","Magenta"))
                Start-Sleep -Milliseconds 100
            }
        }
        elseif ($name -eq "PHASE 7") {
            $token = -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 32 | ForEach-Object {[char]$_})
            Write-Host "  [ PHASE 7 ] Session hijacked. Token: $token" -ForegroundColor Green
            Start-Sleep -Milliseconds 300
        }
        elseif ($name -eq "PHASE 8") {
            for ($prog=10; $prog -le 100; $prog+=10) {
                Write-Host "  [ UPLOAD ] Progress: $prog% [$prog%]" -ForegroundColor Green
                Start-Sleep -Milliseconds 200
            }
        }
        elseif ($name -eq "PHASE 9") {
            Write-Host "  [ PHASE 9 ] index.html >> REPLACED" -ForegroundColor Green
            Write-Host "  [ PHASE 9 ] index.php >> REPLACED" -ForegroundColor Green
            Start-Sleep -Milliseconds 300
        }
        elseif ($name -eq "PHASE 10") {
            Write-Host "  [ PHASE 10 ] Access logs >> PURGED" -ForegroundColor Cyan
            Write-Host "  [ PHASE 10 ] Error logs >> PURGED" -ForegroundColor Cyan
            Write-Host "  [ PHASE 10 ] Bash history >> PURGED" -ForegroundColor Cyan
            Start-Sleep -Milliseconds 300
        }
        elseif ($name -eq "PHASE 11") {
            Write-Host "  [ PHASE 11 ] Shell access: ESTABLISHED" -ForegroundColor Red
            Write-Host "  [ PHASE 11 ] Persistence: ACTIVE" -ForegroundColor Red
            Start-Sleep -Milliseconds 300
        }
        else {
            Start-Sleep -Milliseconds 400
        }
    }
    
    Write-Host ""
    $rainbow = @("Red","DarkRed","Yellow","DarkYellow","Green","Cyan","Blue","Magenta")
    for ($i=0; $i -lt 8; $i++) {
        Write-Host ("#" * 100) -ForegroundColor $rainbow[$i]
    }
    Write-Host ""
}

function Invoke-Deface {
    param([string]$Target, [string]$TemplatePath)
    
    Write-Host ""
    Write-Host "  === DEFACE SEQUENCE INITIATED - TARGET: $Target ===" -ForegroundColor Red
    Write-Host ""
    
    Invoke-DramaticLoad -Target $Target
    
    $targetFile = $null
    
    if ($Target -match "localhost" -or $Target -match "127\.0\.0\.1") {
        $possiblePaths = @(
            ".\target_site.html",
            ".\index.html",
            ".\public\index.html",
            ".\www\index.html",
            ".\htdocs\index.html",
            ".\dist\index.html"
        )
        
        $foundFiles = Get-ChildItem -Path . -Recurse -Filter "target_site.html" -ErrorAction SilentlyContinue
        if (-not $foundFiles) {
            $foundFiles = Get-ChildItem -Path . -Recurse -Filter "index.html" -ErrorAction SilentlyContinue | Select-Object -First 1
        }
        
        if ($foundFiles) {
            $targetFile = $foundFiles.FullName
        } else {
            foreach ($pp in $possiblePaths) {
                if (Test-Path $pp) {
                    $targetFile = Resolve-Path $pp
                    break
                }
            }
        }
    } else {
        Write-Host "  [ WARN ] Remote targets require additional setup. Use localhost for testing." -ForegroundColor Yellow
        return
    }
    
    if (-not $targetFile) {
        Write-Host "  [ ERROR ] No target HTML file found in current directory." -ForegroundColor Red
        Write-Host "  [ HINT ] Make sure target_site.html or index.html exists." -ForegroundColor DarkGray
        return
    }
    
    Write-Host "  [ TARGET ] File found: $targetFile" -ForegroundColor Cyan
    
    $backupPath = "$targetFile.bak"
    try {
        Copy-Item -Path $targetFile -Destination $backupPath -Force
        Write-Host "  [ BACKUP ] Original saved to: $backupPath" -ForegroundColor Green
    } catch {
        Write-Host "  [ WARN ] Could not create backup: $_" -ForegroundColor Yellow
    }
    
    $templateContent = $null
    if ($TemplatePath -and (Test-Path $TemplatePath)) {
        $templateContent = Get-Content -Path $TemplatePath -Raw
        Write-Host "  [ TEMPLATE ] Loaded from file: $TemplatePath" -ForegroundColor Green
    } else {
        $templateContent = @'
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>HACKED BY ZYIN</title>
    <style>
        body { 
            background: #000; 
            color: #0f0; 
            font-family: 'Courier New', monospace; 
            display: flex; 
            justify-content: center; 
            align-items: center; 
            height: 100vh; 
            margin: 0;
            overflow: hidden;
        }
        .container { text-align: center; }
        h1 { 
            font-size: 4rem; 
            text-shadow: 0 0 20px #0f0; 
            animation: glitch 1s infinite;
        }
        p { font-size: 1.2rem; opacity: 0.8; }
        @keyframes glitch {
            0%, 100% { transform: translate(0); }
            20% { transform: translate(-2px, 2px); }
            40% { transform: translate(2px, -2px); }
            60% { transform: translate(-2px, -2px); }
            80% { transform: translate(2px, 2px); }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>SYSTEM COMPROMISED</h1>
        <p>This site has been defaced by ZYIN SCINDICATE</p>
        <p>Your security is an illusion.</p>
        <p style="margin-top: 2rem; font-size: 0.9rem; color: #333;">Original site backed up. No data was harmed.</p>
    </div>
</body>
</html>
'@
        Write-Host "  [ TEMPLATE ] Using default ZYIN template" -ForegroundColor Yellow
    }
    
    try {
        Set-Content -Path $targetFile -Value $templateContent -Force -Encoding UTF8
        Write-Host ""
        Write-Host "  [ SUCCESS ] Payload delivered to $Target" -ForegroundColor Green
        Write-Host "  [ SUCCESS ] File overwritten: $targetFile" -ForegroundColor Green
        Write-Host "  [ SUCCESS ] Cache purged." -ForegroundColor Green
        Write-Host "  [ SUCCESS ] Logs sanitized." -ForegroundColor Green
        Write-Host "  [ SUCCESS ] Origin trace: NULL." -ForegroundColor Green
        Write-Host ""
        Write-Host "  [ RESULT ] Target $Target has been defaced." -ForegroundColor Yellow
        Write-Host "  [ LOCAL ] Refresh your browser to see changes." -ForegroundColor Cyan
        Write-Host "  [ RESTORE ] Run: Copy-Item '$backupPath' '$targetFile' -Force" -ForegroundColor DarkGray
    } catch {
        Write-Host "  [ FAILED ] Could not write to target: $_" -ForegroundColor Red
    }
    
    Write-Host ""
}

function Invoke-PortScan {
    param([string]$Target)
    
    Write-Host ""
    Write-Host "  [ SCAN ] Initiating port scan on $Target..." -ForegroundColor Cyan
    Write-Host ""
    
    $commonPorts = @(21,22,23,25,53,80,110,143,443,3306,3389,5432,8080,8443,9000)
    $openPorts = @()
    
    foreach ($port in $commonPorts) {
        $client = New-Object System.Net.Sockets.TcpClient
        $connection = $client.BeginConnect($Target, $port, $null, $null)
        $wait = $connection.AsyncWaitHandle.WaitOne(500, $false)
        
        if ($wait -and $client.Connected) {
            Write-Host "  [ OPEN ] Port $port/tcp - OPEN" -ForegroundColor Green
            $openPorts += $port
            $client.Close()
        } else {
            Write-Host "  [ CLOSED ] Port $port/tcp - FILTERED" -ForegroundColor DarkGray
        }
    }
    
    Write-Host ""
    Write-Host "  [ RESULT ] Scan complete. Open ports: $($openPorts -join ', ')" -ForegroundColor Yellow
    Write-Host ""
}

function Invoke-Inject {
    param([string]$FilePath, [string]$Payload)
    
    if (-not (Test-Path $FilePath)) {
        Write-Host "  [ ERROR ] File not found: $FilePath" -ForegroundColor Red
        return
    }
    
    $backup = "$FilePath.bak"
    Copy-Item $FilePath $backup -Force
    
    $content = Get-Content $FilePath -Raw
    $injected = $content -replace '</body>', "$Payload`n</body>"
    
    Set-Content -Path $FilePath -Value $injected -Force
    Write-Host "  [ SUCCESS ] Payload injected into $FilePath" -ForegroundColor Green
    Write-Host "  [ BACKUP ] Original saved: $backup" -ForegroundColor Cyan
}

Show-Boot

while ($true) {
    Write-Host "zyin@scindicate" -ForegroundColor Green -NoNewline
    Write-Host ":" -ForegroundColor White -NoNewline
    Write-Host "~" -ForegroundColor Yellow -NoNewline
    Write-Host "$ " -ForegroundColor White -NoNewline
    
    $input = Read-Host
    $parts = $input -split '\s+', 3
    $cmd = $parts[0].ToLower()
    $arg1 = if ($parts.Length -gt 1) { $parts[1] } else { $null }
    $arg2 = if ($parts.Length -gt 2) { $parts[2] } else { $null }
    
    switch ($cmd) {
        "/h" { Show-Help }
        "h" { Show-Help }
        "help" { Show-Help }
        
        "deface" {
            if (-not $arg1) {
                Write-Host "  [ ERROR ] Usage: deface <target>" -ForegroundColor Red
                continue
            }
            Invoke-Deface -Target $arg1 -TemplatePath $arg2
        }
        
        "scan" {
            if (-not $arg1) {
                Write-Host "  [ ERROR ] Usage: scan <target_ip_or_domain>" -ForegroundColor Red
                continue
            }
            Invoke-PortScan -Target $arg1
        }
        
        "inject" {
            if (-not $arg1 -or -not $arg2) {
                Write-Host "  [ ERROR ] Usage: inject <file_path> <payload_string>" -ForegroundColor Red
                continue
            }
            Invoke-Inject -FilePath $arg1 -Payload $arg2
        }
        
        "exit" { 
            Write-Host ""
            Write-Host "  [ SYSTEM ] Session terminated. Goodbye, Boss." -ForegroundColor Green
            exit 
        }
        "quit" { 
            Write-Host ""
            Write-Host "  [ SYSTEM ] Session terminated. Goodbye, Boss." -ForegroundColor Green
            exit 
        }
        "clear" { Show-Boot }
        "cls" { Show-Boot }
        
        "" { continue }
        
        default {
            Write-Host "  [ ERROR ] Unknown command: '$cmd'" -ForegroundColor Red
            Write-Host "  [ HINT ] Use /h for command list." -ForegroundColor DarkGray
        }
    }
}

} catch {
    Write-Host ""
    Write-Host "FATAL ERROR: $_" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
    Read-Host "Press Enter to close"
}

