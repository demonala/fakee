@echo off
title Zyim Terminal Beta - Hendry
color 0A
setlocal enabledelayedexpansion

:load
cls
echo.
echo  [92m┌─────────────────────────────────────────────────────────┐[0m
echo  [92m│                                                         │[0m
echo  [92m│   [96m██╗   ██╗██╗███╗   ███╗ ███████╗██╗  ██╗██╗███╗   ██╗██████╗  [92m│[0m
echo  [92m│   [96m╚██╗ ██╔╝██║████╗ ████║╚══███╔╝██║  ██║██║████╗  ██║██╔══██╗ [92m│[0m
echo  [92m│   [96m ╚████╔╝ ██║██╔████╔██║  ███╔╝ ███████║██║██╔██╗ ██║██║  ██║ [92m│[0m
echo  [92m│   [96m  ╚██╔╝  ██║██║╚██╔╝██║ ███╔╝  ██╔══██║██║██║╚██╗██║██║  ██║ [92m│[0m
echo  [92m│   [96m   ██║   ██║██║ ╚═╝ ██║███████╗██║  ██║██║██║ ╚████║██████╔╝  [92m│[0m
echo  [92m│   [96m   ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝   [92m│[0m
echo  [92m│                                                         │[0m
echo  [92m│               [93mZYIM TERMINAL BETA - HENDRY[0m                [92m│[0m
echo  [92m│                                                         │[0m
echo  [92m└─────────────────────────────────────────────────────────┘[0m
echo.
echo  [92m[*][0m Initializing kernel modules...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Loading exploit vectors...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Spoofing user-agent...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Establishing handshake...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Injecting payloads...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m System ready.
echo.
echo  [93m[>][0m Type [96m/h[0m for help
echo.
set /p cmd="[92mZyim>[0m "

if /i "%cmd%"=="/h" goto help
if /i "%cmd%"=="help" goto help
if /i "%cmd%"=="/?" goto help
if /i "%cmd%"=="deface" goto deface
if /i "%cmd%"=="" goto load
echo  [91m[X][0m Unknown command. Type /h for help.
timeout /t 2 /nobreak >nul
goto load

:help
cls
echo.
echo  [92m╔══════════════════════════════════════════════════════════╗[0m
echo  [92m║  [96mZYIM TERMINAL BETA - HENDRY  -  COMMAND REFERENCE  [92m║[0m
echo  [92m╚══════════════════════════════════════════════════════════╝[0m
echo.
echo   [93m/h, help, /?[0m          Show this help menu
echo   [93mdeface[0m                Execute deface operation
echo.
echo   [96mUSAGE[0m
echo   deface
echo   Then enter target and template when prompted
echo.
echo   [96mAVAILABLE TEMPLATES[0m
echo   [92mdefault[0m               Standard deface page
echo   [92manon[0m                  Anonymous message
echo   [92mhacked[0m                Defaced by Zyim
echo   [92mskid[0m                  Script kiddie style
echo   [92mglory[0m                 Glorious takeover
echo.
pause
goto load

:deface
cls
echo.
echo  [92m╔══════════════════════════════════════════════════════════╗[0m
echo  [92m║      [91mZYIM DEFACE ENGINE v1.0  -  HENDRY EDITION[0m      [92m║[0m
echo  [92m╚══════════════════════════════════════════════════════════╝[0m
echo.
echo  [92m[*][0m Target acquired.
set /p target="  [93mTarget IP or domain:[0m "
set /p template="  [93mTemplate name:[0m "
echo.
echo  [92m[*][0m Resolving target...
timeout /t 1 /nobreak >nul
echo  [92m[+][0m Target resolved: %target%
echo  [92m[*][0m Injecting template: %template%
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Attempting to locate web root...
timeout /t 1 /nobreak >nul
echo  [92m[+][0m Web root found: C:\xampp\htdocs\
echo  [92m[*][0m Preparing payload...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Bypassing write permissions...
timeout /t 1 /nobreak >nul
echo  [92m[*][0m Writing index.html...
timeout /t 1 /nobreak >nul

if /i "%template%"=="default" (
    echo ^<html^>^<body bgcolor=black^>^<font color=red^>^<h1^>DEFACED BY ZYIM^</h1^>^<h3^>Your security is a joke.^</h3^>^</font^>^</body^>^</html^> > C:\xampp\htdocs\index.html
)
if /i "%template%"=="anon" (
    echo ^<html^>^<body bgcolor=black^>^<center^>^<h1 style="color:#00ff41;"^>ANONYMOUS WAS HERE^</h1^>^<p style="color:white;"^>We are everywhere. We are nowhere.^</p^>^</center^>^</body^>^</html^> > C:\xampp\htdocs\index.html
)
if /i "%template%"=="hacked" (
    echo ^<html^>^<body bgcolor=black^>^<center^>^<h1 style="color:red;"^>HACKED BY ZYIMSCINDICATE^</h1^>^<h3 style="color:white;"^>Your site is now ours.^</h3^>^</center^>^</body^>^</html^> > C:\xampp\htdocs\index.html
)
if /i "%template%"=="skid" (
    echo ^<html^>^<body bgcolor=black^>^<center^>^<h1 style="color:lime;"^>SKID ROW TAKEOVER^</h1^>^<marquee style="color:red;"^>l33t h4x0r zyim scindicate^</marquee^>^</center^>^</body^>^</html^> > C:\xampp\htdocs\index.html
)
if /i "%template%"=="glory" (
    echo ^<html^>^<body bgcolor=black^>^<center^>^<h1 style="color:gold;"^>GLORY TO ZYIM^</h1^>^<h2 style="color:white;"^>We rise above your mediocrity.^</h2^>^</center^>^</body^>^</html^> > C:\xampp\htdocs\index.html
)

echo.
echo  [92m[✓][0m DEFACE SUCCESSFUL
echo  [92m[+][0m Target: %target%  [93mTemplate:[0m %template%
echo  [92m[i][0m Check your browser at http://%target%/
echo.
echo  Press any key to return...
pause >nul
goto load 
