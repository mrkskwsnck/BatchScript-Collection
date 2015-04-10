@ECHO OFF

REM Performs a reconnect of a routers internet connection based on a DD-WRT firmware using cURL especially
REM http://www.paehl.de/reconnect/
REM NOTE: User cannot contain whitespaces
REM NOTE: Password cannot contain whitespaces
REM Works with DD-WRT v23sp2 so far

SETLOCAL

SET IP=%1
SET USER=%2
SET /P PWD=Password: 

curl "http://%USER%:%PWD%@%IP%/apply.cgi" -d "submit_button=Status_Router&submit_type=Disconnect_pppoe&change_action=gozila_cgi&action=Apply" > NUL
IF NOT %ERRORLEVEL% EQU 0 GOTO END
curl "http://%USER%:%PWD%@%IP%/apply.cgi" -d "submit_button=Status_Router&submit_type=Connect_pppoe&change_action=gozila_cgi&action=Apply" > NUL
:END

ENDLOCAL

