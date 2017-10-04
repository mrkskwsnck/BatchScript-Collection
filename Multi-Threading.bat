@ECHO OFF

:THREAD0
ECHO Thread 0
TIMEOUT /T 1 /NOBREAK > NUL
CALL :THREAD1

:THREAD1
ECHO Thread 1
TIMEOUT /T 1 /NOBREAK > NUL
CALL :THREAD0

REM Das Sprungziel :EOF ist implizit definiert und markiert das Dateiende
