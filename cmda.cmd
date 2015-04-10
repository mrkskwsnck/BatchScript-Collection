@ECHO OFF

REM Runs %COMSPEC% with arguments As local Administrator user  
REM All the given arguments will be passed through
REM Copyright 2008 by Markus Kwasnicki
REM Note to quote whitespaces  

SETLOCAL
SET ARGS=%*
RUNAS /PROFILE /ENV /USER:Administrator "%COMSPEC:"=\"% %ARGS:"=\"%"
IF ERRORLEVEL 1 PAUSE
ENDLOCAL

