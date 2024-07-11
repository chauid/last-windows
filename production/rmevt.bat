@echo off
bcdedit > nul
if %errorlevel% equ 1 goto noadmin
set option=true
choice /m "Shutdown after event log remove done."
if %errorlevel% equ 1 set option=true
if %errorlevel% equ 2 set option=false
for /f %%i in ('wevtutil el') do (
  wevtutil cl "%%i" > nul
  cls
  echo removing...
)
cls & echo remove complete!
if %option% equ true shutdown /f /s /t 20
timeout /t 5
exit
:noadmin
echo No Admin...
pause > nul
exit