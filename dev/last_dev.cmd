@echo off
rem 7001 : Logon
rem 7002 : Logoff
setlocal ENABLEDELAYEDEXPANSION
rem 초기값 설정 
chcp 949 > nul
set orderby=asc
rem 명령어 구문 확인 
set param1=%1
set param2=%2
set /A syntax_check_count=0
if "%param1%"=="" set /A syntax_check_count=!syntax_check_count!+1
if "%param1%"=="--on" set /A syntax_check_count=!syntax_check_count!+1
if "%param1%"=="--off" set /A syntax_check_count=!syntax_check_count!+1
if "%param1%"=="-A" set /A syntax_check_count=!syntax_check_count!+1
if "%param1%"=="--all" set /A syntax_check_count=!syntax_check_count!+1
if "%param1:~0,2%"=="-O" (
   if "%param1:~3%"=="" set error_type=order_no_param& goto input_syntax_error
   if NOT "%param1%"=="-O:D" if NOT "%param1%"=="-O:A" (
      set error_type=order_invalid_argument
      set error_argument=%param1%
      goto input_syntax_error
   )
)
if "%param1%"=="-O:D" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=desc
)
if "%param1%"=="-O:A" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=asc
)
if "%param1:~0,7%"=="--order" (
   if "%param1:~8%"=="" set error_type=order_no_param& goto input_syntax_error
   if NOT "%param1%"=="--order:D" if NOT "%param1%"=="--order:A" (
      set error_type=order_invalid_argument
      set error_argument=%param1%
      goto input_syntax_error
   )
)
if "%param1%"=="--order:D" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=desc
)
if "%param1%"=="--order:A" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=asc
)
if "%param1%"=="-V" goto version_print
if "%param1%"=="--version" goto version_print
if "%param1%"=="-h" goto usage
if "%param1%"=="--help" goto usage
if %syntax_check_count% EQU 0 (
   set error_type=invalid_param
   set error_param=%param1%
   goto input_syntax_error
)
set /A syntax_check_count=0
if "%param2%"=="" set /A syntax_check_count=!syntax_check_count!+1
if "%param2%"=="--on" set /A syntax_check_count=!syntax_check_count!+1
if "%param2%"=="--off" set /A syntax_check_count=!syntax_check_count!+1
if "%param2%"=="-A" set /A syntax_check_count=!syntax_check_count!+1
if "%param2%"=="--all" set /A syntax_check_count=!syntax_check_count!+1
if "%param2:~0,2%"=="-O" (
   if "%param2:~3%"=="" set error_type=order_no_param& goto input_syntax_error
   if NOT "%param2%"=="-O:D" if NOT "%param2%"=="-O:A" (
      set error_type=order_invalid_argument
      set error_argument=%param2%
      goto input_syntax_error
   )
)
if "%param2%"=="-O:D" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=desc
)
if "%param2%"=="-O:A" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=asc
)
if "%param2:~0,7%"=="--order" (
   if "%param2:~8%"=="" set error_type=order_no_param& goto input_syntax_error
   if NOT "%param2%"=="--order:D" if NOT "%param2%"=="--order:A" (
      set error_type=order_invalid_argument
      set error_argument=%param2%
      goto input_syntax_error
   )
)
if "%param2%"=="--order:D" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=desc
)
if "%param2%"=="--order:A" (
   set /A syntax_check_count=!syntax_check_count!+1
   set orderby=asc
)
if "%param2%"=="-V" goto version_print
if "%param2%"=="--version" goto version_print
if "%param2%"=="-h" goto usage
if "%param2%"=="--help" goto usage
if %syntax_check_count% EQU 0 (
   set error_type=invalid_param
   set error_param=%param2%
   goto input_syntax_error
)
goto main
:input_syntax_error
if "%error_type%"=="order_no_param" echo 오류: '-O' 또는 '--order'에는 매개변수가 필요합니다.
if "%error_type%"=="order_invalid_argument" echo 오류: 허용되지 않은 매개변수 - '%error_argument%'
if "%error_type%"=="invalid_param" echo 오류: 잘못된 인수/옵션 - '%error_param%'
echo 'last --help' 또는 'last -h'를 시도하여 도움말을 참조하세요.
goto end
:copy_log_to_combi_log
if "%log_param%"=="logon" (
   set combi_log[%combi_index%].type=로그온
   set combi_log[%combi_index%].year=!logon_log[%logon_index%].year!
   set combi_log[%combi_index%].month=!logon_log[%logon_index%].month!
   set combi_log[%combi_index%].day=!logon_log[%logon_index%].day!
   set combi_log[%combi_index%].hour=!logon_log[%logon_index%].phour!
   set combi_log[%combi_index%].minute=!logon_log[%logon_index%].minute!
   set combi_log[%combi_index%].second=!logon_log[%logon_index%].second!
   set /A logon_index=%logon_index%+1
) else (
   set combi_log[%combi_index%].type=로그오프
   set combi_log[%combi_index%].year=!logoff_log[%logoff_index%].year!
   set combi_log[%combi_index%].month=!logoff_log[%logoff_index%].month!
   set combi_log[%combi_index%].day=!logoff_log[%logoff_index%].day!
   set combi_log[%combi_index%].hour=!logoff_log[%logoff_index%].phour!
   set combi_log[%combi_index%].minute=!logoff_log[%logoff_index%].minute!
   set combi_log[%combi_index%].second=!logoff_log[%logoff_index%].second!
   set /A logoff_index=%logoff_index%+1
)
goto :eof
rem goto return_log_%call_value%
:main
rem 로그 수 계산 
set /A logoff_count=0
for /F "tokens=* usebackq" %%I IN (`wevtutil qe System /rd:false /q:"*[System[(EventID=7002)]]"`) DO (
   set /A logoff_count=!logoff_count!+1
)
if %logoff_count% EQU 0 set logoff_exist=false
set /A logoff_count=%logoff_count%-1
set /A logon_count=0
for /F "tokens=* usebackq" %%I IN (`wevtutil qe System /rd:false /q:"*[System[(EventID=7001)]]"`) DO (
   set /A logon_count=!logon_count!+1
)
if %logon_count% EQU 0 set logon_exist=false
set /A logon_count=%logon_count%-1

if "%logoff_exist%"=="false" if "%logon_exist%"=="false" goto no_log

set /A logoff_index=0
for /F "tokens=5 usebackq" %%I in (`wevtutil qe System /rd:false /q:"*[System[(EventID=7002)]]"`) DO (
   set logoff_log[!logoff_index!]=%%I
   set /A logoff_index=!logoff_index!+1
)
set /A logon_index=0
for /F "tokens=5 usebackq" %%I in (`wevtutil qe System /rd:false /q:"*[System[(EventID=7001)]]"`) DO (
   set logon_log[!logon_index!]=%%I
   set /A logon_index=!logon_index!+1
)

set /A end_index=%logoff_index%
set /A index=0
:logoff_log_loop
set logoff_log[%index%]=!logoff_log[%index%]:~12,19!
set /A logoff_log[%index%].year=!logoff_log[%index%]:~0,4!
if "!logoff_log[%index%]:~5,1!"=="0" (
   set /A logoff_log[%index%].month=!logoff_log[%index%]:~6,1!
) else (
   set /A logoff_log[%index%].month=!logoff_log[%index%]:~5,2!
)
if "!logoff_log[%index%]:~8,1!"=="0" (
   set /A logoff_log[%index%].day=!logoff_log[%index%]:~9,1!
) else (
   set /A logoff_log[%index%].day=!logoff_log[%index%]:~8,2!
)
if "!logoff_log[%index%]:~11,1!"=="0" (
   set /A logoff_log[%index%].hour=!logoff_log[%index%]:~12,1!+9
) else (
   set /A logoff_log[%index%].hour=!logoff_log[%index%]:~11,2!+9
)
rem TimeZone에 의한 시간값 보정. 월 계산 안 함. 월 넘어가는 거는 31, 30일 계산 + 윤년 계산이기에 32일이 나올 수 있음. 
if !logoff_log[%index%].hour! GEQ 24 (
   set /A logoff_log[%index%].hour=!logoff_log[%index%].hour!-24
   set /A logoff_log[%index%].day=!logoff_log[%index%].day!+1
)
if !logoff_log[%index%].hour! LSS 10 (
   set logoff_log[%index%].phour=0!logoff_log[%index%].hour!
) else (
   set logoff_log[%index%].phour=!logoff_log[%index%].hour!
)
set logoff_log[%index%].minute=!logoff_log[%index%]:~14,2!
set logoff_log[%index%].second=!logoff_log[%index%]:~17,2!
set /A index=%index%+1
if "%index%"=="%end_index%" goto out_logoff_log_loop
goto logoff_log_loop
:out_logoff_log_loop

set /A end_index=%logon_index%
set /A index=0
:logon_log_loop
set logon_log[%index%]=!logon_log[%index%]:~12,19!
set /A logon_log[%index%].year=!logon_log[%index%]:~0,4!
if "!logon_log[%index%]:~5,1!"=="0" (
   set /A logon_log[%index%].month=!logon_log[%index%]:~6,1!
) else (
   set /A logon_log[%index%].month=!logon_log[%index%]:~5,2!
)
if "!logon_log[%index%]:~8,1!"=="0" (
   set /A logon_log[%index%].day=!logon_log[%index%]:~9,1!
) else (
   set /A logon_log[%index%].day=!logon_log[%index%]:~8,2!
)
if "!logon_log[%index%]:~11,1!"=="0" (
   set /A logon_log[%index%].hour=!logon_log[%index%]:~12,1!+9
) else (
   set /A logon_log[%index%].hour=!logon_log[%index%]:~11,2!+9
)
rem TimeZone에 의한 시간값 보정. 월 계산 안 함. 월 넘어가는 거는 31, 30일 계산 + 윤년 계산이기에 32일이 나올 수 있음.  
if !logon_log[%index%].hour! GEQ 24 (
   set /A logon_log[%index%].hour=!logon_log[%index%].hour!-24
   set /A logon_log[%index%].day=!logon_log[%index%].day!+1
)
if !logon_log[%index%].hour! LSS 10 (
   set logon_log[%index%].phour=0!logon_log[%index%].hour!
) else (
   set logon_log[%index%].phour=!logon_log[%index%].hour!
)
set logon_log[%index%].minute=!logon_log[%index%]:~14,2!
set logon_log[%index%].second=!logon_log[%index%]:~17,2!
set /A index=%index%+1
if "%index%"=="%end_index%" goto out_logon_log_loop
goto logon_log_loop
:out_logon_log_loop

rem overflow 발생 시 NULL값이 없으므로 최대값으로 선언 
set /A startup_overflow_index=%logon_count%+1
set /A shutdown_overflow_index=%logoff_count%+1
set logon_log[%startup_overflow_index%].year=9999
set logoff_log[%shutdown_overflow_index%].year=9999

set /A logon_index=0
set /A logoff_index=0
:merge_log_loop
if %logon_index% GTR %logon_count% if %logoff_index% GTR %logoff_count% goto print_log
set /A combi_index=%logon_index%+%logoff_index%

:compare_year
set call_value=year
if !logon_log[%logon_index%].year! EQU !logoff_log[%logoff_index%].year! goto compare_month
if !logon_log[%logon_index%].year! LSS !logoff_log[%logoff_index%].year! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop
:compare_month
set call_value=month
if !logon_log[%logon_index%].month! EQU !logoff_log[%logoff_index%].month! goto compare_day
if !logon_log[%logon_index%].month! LSS !logoff_log[%logoff_index%].month! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop
:compare_day
set call_value=day
if !logon_log[%logon_index%].day! EQU !logoff_log[%logoff_index%].day! goto compare_hour
if !logon_log[%logon_index%].day! LSS !logoff_log[%logoff_index%].day! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop
:compare_hour
set call_value=hour
if !logon_log[%logon_index%].hour! EQU !logoff_log[%logoff_index%].hour! goto compare_minute
if !logon_log[%logon_index%].hour! LSS !logoff_log[%logoff_index%].hour! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop
:compare_minute
set call_value=minute
if !logon_log[%logon_index%].minute! EQU !logoff_log[%logoff_index%].minute! goto compare_second
if !logon_log[%logon_index%].minute! LSS !logoff_log[%logoff_index%].minute! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop
:compare_second
if !logon_log[%logon_index%].second! LEQ !logoff_log[%logoff_index%].second! (
   set log_param=logon
) else (
   set log_param=logoff
)
call :copy_log_to_combi_log
goto merge_log_loop

:print_log
rem 출력 
set /A logoff_count_print=%logoff_count%+1
set /A logon_count_print=%logon_count%+1
set /A combi_count=%logoff_count%+%logon_count%+1
echo.
if "%param1%"=="--on" goto logon_print
if "%param1%"=="--off" goto logoff_print
goto all_print
:logon_print
echo %logon_count_print%건의 로그온 이벤트가 있었습니다.
echo ------------------------------------------------------------
echo 이벤트      시각
if "%orderby%"=="asc" (
   for /L %%I IN (0,1,%logon_count%) DO (
      echo 로그온      !logon_log[%%I].year!.!logon_log[%%I].month!.!logon_log[%%I].day!. !logon_log[%%I].phour!:!logon_log[%%I].minute!:!logon_log[%%I].second!
   )
)
if "%orderby%"=="desc" (
   for /L %%I IN (%logon_count%,-1,0) DO (
      echo 로그온      !logon_log[%%I].year!.!logon_log[%%I].month!.!logon_log[%%I].day!. !logon_log[%%I].phour!:!logon_log[%%I].minute!:!logon_log[%%I].second!
   )
)
goto end
:logoff_print
echo %logoff_count_print%건의 로그오프 이벤트가 있었습니다.
echo ------------------------------------------------------------
echo 이벤트      시각
if "%orderby%"=="asc" (
   for /L %%I IN (0,1,%logoff_count%) DO (
      echo 로그오프    !logoff_log[%%I].year!.!logoff_log[%%I].month!.!logoff_log[%%I].day!. !logoff_log[%%I].phour!:!logoff_log[%%I].minute!:!logoff_log[%%I].second!
   ) 
)
if "%orderby%"=="desc" (
   for /L %%I IN (%logoff_count%,-1,%logoff_count%) DO (
      echo 로그오프    !logoff_log[%%I].year!.!logoff_log[%%I].month!.!logoff_log[%%I].day!. !logoff_log[%%I].phour!:!logoff_log[%%I].minute!:!logoff_log[%%I].second!
   ) 
)
goto end
:all_print
echo %logon_count_print%건의 로그온 이벤트와 %logoff_count_print%건의 로그오프 이벤트가 있었습니다.
echo ------------------------------------------------------------
echo 이벤트      시각
if "%orderby%"=="asc" (
   for /L %%I IN (0,1,%combi_count%) DO (
      if "!combi_log[%%I].type!"=="로그온" (
         echo !combi_log[%%I].type!      !combi_log[%%I].year!.!combi_log[%%I].month!.!combi_log[%%I].day!. !combi_log[%%I].hour!:!combi_log[%%I].minute!:!combi_log[%%I].second!
      ) else (
         echo !combi_log[%%I].type!    !combi_log[%%I].year!.!combi_log[%%I].month!.!combi_log[%%I].day!. !combi_log[%%I].hour!:!combi_log[%%I].minute!:!combi_log[%%I].second!
      )
   )  
)
if "%orderby%"=="desc" (
   for /L %%I IN (%combi_count%,-1,0) DO (
      if "!combi_log[%%I].type!"=="로그온" (
         echo !combi_log[%%I].type!      !combi_log[%%I].year!.!combi_log[%%I].month!.!combi_log[%%I].day!. !combi_log[%%I].hour!:!combi_log[%%I].minute!:!combi_log[%%I].second!
      ) else (
         echo !combi_log[%%I].type!    !combi_log[%%I].year!.!combi_log[%%I].month!.!combi_log[%%I].day!. !combi_log[%%I].hour!:!combi_log[%%I].minute!:!combi_log[%%I].second!
      )
   )  
)
goto end
:usage
echo 사용법: last [option]
echo.
echo Windows EventLog 기반 로그온/오프 기록 표시
echo.
echo Options:
echo      --on          로그온 목록만 표시
echo      --off         로그오프 목록만 표시
echo   -A --all         로그온/오프 목록 표시 [기본값]
echo   -O               날짜/시간순으로 정렬 [기본값: -O:D]
echo      --order:D     D  내림차순(가장 최신 항목부터)
echo      --order:A     A  오름차순(가장 오래된 항목부터)
echo   -V --version     버전 확인
echo   -h --help        도움말 표시(현재 창 표시)
goto end
:version_print
echo last command for Windows v0.9
goto end
:no_log
echo 로그온/오프 기록이 없습니다. 자세한 이벤트 목록을 확인하기 위해 이벤트 뷰어를 참조하세요.
choice /N /M "이벤트 뷰어를 실행하시겠습니까? (Y,N)"
if "%ERRORLEVEL%"=="1" start eventvwr.msc
goto end
:noadmin
echo 관리자 권한으로 실행해주세요. 
:end
endlocal