@echo off
goto P2
:P1
echo p1
set /a values=123
goto :eof
:P2
echo first
echo t=%values%
echo p2
call :P1
echo exit
echo t=%values%
pause
