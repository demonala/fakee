@echo off
setlocal EnableDelayedExpansion
title ZYIM SCINDICATE v2.4 - TERMINAL
color 0A
mode con: cols=120 lines=35

:: Hide cursor
echo [?25l

:boot
cls
echo.
echo  [38;5;196m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;202m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;208m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;214m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;220m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;226m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;190m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;154m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;118m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;82m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;46m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;51m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;39m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;27m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;21m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;93m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;129m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;201m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo.
echo  [38;5;196m╔══════════════════════════════════════════════════════════════════════════════════════════════════════════════╗[0m
echo  [38;5;202m║                                                                                                              ║[0m
echo  [38;5;208m║   [1m[38;5;255m███████╗██╗   ██╗██╗███╗   ███╗    ███████╗ ██████╗██╗███╗   ██╗██████╗ ██╗ ██████╗ █████╗ ████████╗███████╗[0m   [38;5;208m║[0m
echo  [38;5;214m║   [1m[38;5;255m╚══███╔╝╚██╗ ██╔╝██║████╗ ████║    ██╔════╝██╔════╝██║████╗  ██║██╔══██╗██║██╔════╝██╔══██╗╚══██╔══╝██╔════╝[0m   [38;5;214m║[0m
echo  [38;5;220m║   [1m[38;5;255m  ███╔╝  ╚████╔╝ ██║██╔████╔██║    ███████╗██║     ██║██╔██╗ ██║██║  ██║██║██║     ███████║   ██║   █████╗  [0m   [38;5;220m║[0m
echo  [38;5;226m║   [1m[38;5;255m ███╔╝    ╚██╔╝  ██║██║╚██╔╝██║    ╚════██║██║     ██║██║╚██╗██║██║  ██║██║██║     ██╔══██║   ██║   ██╔══╝  [0m   [38;5;226m║[0m
echo  [38;5;190m║   [1m[38;5;255m███████╗   ██║   ██║██║ ╚═╝ ██║    ███████║╚██████╗██║██║ ╚████║██████╔╝██║╚██████╗██║  ██║   ██║   ███████╗[0m   [38;5;190m║[0m
echo  [38;5;154m║   [1m[38;5;255m╚══════╝   ╚═╝   ╚═╝╚═╝     ╚═╝    ╚══════╝ ╚═════╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝[0m   [38;5;154m║[0m
echo  [38;5;118m║                                                                                                              ║[0m
echo  [38;5;82m║   [38;5;51m[ TERMINAL ACCESS GRANTED ]    [ PROTOCOL: SCINDICATE ]    [ BUILD: v2.4.0-STABLE ]    [ STATUS: ONLINE ]   [38;5;82m║[0m
echo  [38;5;46m╚══════════════════════════════════════════════════════════════════════════════════════════════════════════════╝[0m
echo.
echo  [38;5;240m[ SYSTEM ] Initializing core modules...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;240m[ SYSTEM ] Loading exploit database...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;240m[ SYSTEM ] Connecting to anonymous proxy chain...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;240m[ SYSTEM ] Masking origin fingerprint...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;82m[ SYSTEM ] [1mREADY.[0m
echo.
echo  [38;5;240mType [38;5;226m/h[0m [38;5;240mfor available commands.[0m
echo.

:mainloop
set /p cmd="[38;5;82mzyim@scindicate[0m[38;5;226m:~$[0m "

if /i "%cmd%"=="/h" goto help
if /i "%cmd%"=="h" goto help
if /i "%cmd%"=="help" goto help
if /i "%cmd%"=="deface" goto deface_input
if /i "%cmd%"=="exit" goto quit
if /i "%cmd%"=="quit" goto quit
if /i "%cmd%"=="clear" goto boot
if /i "%cmd%"=="cls" goto boot

echo  [38;5;196m[ ERROR ] Unknown command: '%cmd%'[0m
echo  [38;5;240m[ HINT ] Use /h for command list.[0m
echo.
goto mainloop

:help
echo.
echo  [38;5;226m╔══════════════════════════════════════════════════════════════════════╗[0m
echo  [38;5;226m║                    [1mZYIM SCINDICATE COMMAND LIST[0m                      [38;5;226m║[0m
echo  [38;5;226m╠══════════════════════════════════════════════════════════════════════╣[0m
echo  [38;5;226m║                                                                      [38;5;226m║[0m
echo  [38;5;226m║   [38;5;82mdeface [38;5;240m(domain_web or local_host_ip)   [38;5;240m- Initiate deface sequence[0m   [38;5;226m║[0m
echo  [38;5;226m║   [38;5;82m/h                                     [38;5;240m- Show this help menu[0m         [38;5;226m║[0m
echo  [38;5;226m║   [38;5;82mexit / quit                            [38;5;240m- Terminate session[0m         [38;5;226m║[0m
echo  [38;5;226m║   [38;5;82mclear / cls                            [38;5;240m- Clear terminal screen[0m     [38;5;226m║[0m
echo  [38;5;226m║                                                                      [38;5;226m║[0m
echo  [38;5;226m╚══════════════════════════════════════════════════════════════════════╝[0m
echo.
echo  [38;5;240m[ USAGE ] Type 'deface' then enter target. After that, paste your HTML template.[0m
echo  [38;5;240m[ NOTE ]  Localhost testing: deface 127.0.0.1 or deface localhost[0m
echo.
goto mainloop

:deface_input
echo.
echo  [38;5;226m[ INPUT ] Enter target (domain_web or local_host_ip_):[0m
set /p target="[38;5;82mzyim@scindicate[0m[38;5;196m[TARGET][0m[38;5;226m:~$[0m "
if "%target%"=="" (
    echo  [38;5;196m[ ERROR ] Target cannot be empty.[0m
    goto mainloop
)
echo  [38;5;82m[ OK ] Target locked: %target%[0m
echo.
echo  [38;5;226m[ INPUT ] Paste your HTML template below (press ENTER twice to execute):[0m
echo  [38;5;240m[ HINT ] You can paste multi-line HTML. Empty line + ENTER to fire.[0m
echo.

set "htmlcode="
:readhtml
set /p line=""
if "!line!"=="" goto firedeface
set "htmlcode=!htmlcode!!line!"
goto readhtml

:firedeface
echo.
echo  [38;5;196m╔══════════════════════════════════════════════════════════════════════╗[0m
echo  [38;5;196m║            [1m[ DEFACE SEQUENCE INITIATED - TARGET: %target% ][0m           [38;5;196m║[0m
echo  [38;5;196m╚══════════════════════════════════════════════════════════════════════╝[0m
echo.

call :dramatic_load

echo  [38;5;82m[ SUCCESS ] Payload delivered to %target%[0m
echo  [38;5;82m[ SUCCESS ] Index overwritten.[0m
echo  [38;5;82m[ SUCCESS ] Cache purged.[0m
echo  [38;5;82m[ SUCCESS ] Logs sanitized.[0m
echo  [38;5;82m[ SUCCESS ] Origin trace: NULL.[0m
echo.
echo  [38;5;226m[ RESULT ] Target %target% has been defaced with your template.[0m
echo  [38;5;240m[ LOCAL ] If localhost, check your browser now.[0m
echo.
goto mainloop

:dramatic_load
echo  [38;5;196m[ PHASE 1 ] Resolving DNS...[0m
call :randcolor
echo  [38;5;196m[ PHASE 1 ] DNS resolved: %target% ^>^> [1m%random%.%random%.%random%.%random%[0m
timeout /t 1 /nobreak >nul

echo  [38;5;202m[ PHASE 2 ] Port scanning common vectors...[0m
for /l %%i in (1,1,8) do (
    call :randcolor
    set /a port=!random! %% 65535 + 1
    echo  [38;5;202m[ PHASE 2 ] Checking port !port!... [1mOPEN[0m
    timeout /t 1 /nobreak >nul
)

echo  [38;5;208m[ PHASE 3 ] Fingerprinting server...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;208m[ PHASE 3 ] Server: Apache/2.4.41 (Ubuntu)[0m
echo  [38;5;208m[ PHASE 3 ] OS: Linux 5.4.0-generic[0m
echo  [38;5;208m[ PHASE 3 ] WAF: None detected[0m
timeout /t 1 /nobreak >nul

echo  [38;5;214m[ PHASE 4 ] Enumerating directories...[0m
for %%d in (admin,config,backup,uploads,wp-content,includes,images,cgi-bin,.env,.git) do (
    call :randcolor
    echo  [38;5;214m[ PHASE 4 ] /%%d/ ... [1mEXPOSED[0m
    timeout /t 1 /nobreak >nul
)

echo  [38;5;220m[ PHASE 5 ] Exploit matching...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;220m[ PHASE 5 ] CVE-2019-XXXX matched ^| Severity: CRITICAL[0m
echo  [38;5;220m[ PHASE 5 ] CVE-2021-XXXX matched ^| Severity: HIGH[0m
timeout /t 1 /nobreak >nul

echo  [38;5;226m[ PHASE 6 ] Injecting payload...[0m
for /l %%i in (1,1,20) do (
    call :randcolor
    set /a hex=!random! %% 255
    echo  [38;5;226m[ INJECT ] 0x!hex! [1m^>^>^>[0m [38;5;82m%target%[0m
    timeout /t 1 /nobreak >nul
)

echo  [38;5;190m[ PHASE 7 ] Bypassing authentication...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;190m[ PHASE 7 ] Session hijacked. Token: !random!!random!!random![0m
timeout /t 1 /nobreak >nul

echo  [38;5;154m[ PHASE 8 ] Uploading template...[0m
set "progress=0"
for /l %%i in (1,1,10) do (
    set /a progress+=10
    call :randcolor
    echo  [38;5;154m[ UPLOAD ] Progress: !progress!%% [1m[[0m[38;5;82m!progress![0m[38;5;154m%%][0m
    timeout /t 1 /nobreak >nul
)

echo  [38;5;118m[ PHASE 9 ] Overwriting index...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;118m[ PHASE 9 ] index.html ^>^> [1mREPLACED[0m
echo  [38;5;118m[ PHASE 9 ] index.php ^>^> [1mREPLACED[0m
timeout /t 1 /nobreak >nul

echo  [38;5;82m[ PHASE 10 ] Cleaning tracks...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;82m[ PHASE 10 ] Access logs ^>^> [1mPURGED[0m
echo  [38;5;82m[ PHASE 10 ] Error logs ^>^> [1mPURGED[0m
echo  [38;5;82m[ PHASE 10 ] Bash history ^>^> [1mPURGED[0m
timeout /t 1 /nobreak >nul

echo  [38;5;196m[ PHASE 11 ] Establishing backdoor...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;196m[ PHASE 11 ] Shell access: [1mESTABLISHED[0m
echo  [38;5;196m[ PHASE 11 ] Persistence: [1mACTIVE[0m
timeout /t 1 /nobreak >nul

echo  [38;5;226m[ PHASE 12 ] Finalizing...[0m
timeout /t 1 /nobreak >nul
echo  [38;5;226m[ PHASE 12 ] Template rendered successfully.[0m
timeout /t 1 /nobreak >nul

echo.
echo  [38;5;196m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;202m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;208m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;214m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;220m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;226m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;190m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;154m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;118m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;82m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;46m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;51m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;39m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;27m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;21m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;93m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;129m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo  [38;5;201m▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓[0m
echo.
goto :eof

:randcolor
set /a rc=!random! %% 15 + 196
if !rc! gtr 231 set /a rc=196
goto :eof

:quit
echo.
echo  [38;5;196m[ SYSTEM ] Session terminated.[0m
echo  [38;5;240m[ SYSTEM ] Clearing memory buffers...[0m
echo  [38;5;240m[ SYSTEM ] Disconnecting from proxy chain...[0m
echo  [38;5;82m[ SYSTEM ] Goodbye, Boss.[0m
echo [?25h
exit /b

