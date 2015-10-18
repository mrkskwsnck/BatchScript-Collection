REM http://www.heise.de/ct/ftp/06/09/126/

@ECHO OFF

REM Backup solution using RSYNC for Windows XP and such

SETLOCAL

SET SOURCE=%1
SET DESTINATION=%2
SET TIMESTAMP=%DATE:~6%%DATE:~3,2%%DATE:~0,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%%TIME:~9%

IF NOT EXIST %SOURCE%\. GOTO END
IF NOT EXIST %DESTINATION%\. GOTO END

FOR /D %%D IN (%DESTINATION%\*) DO SET LATEST=%%~ND%%~XD
IF NOT DEFINED LATEST (
	MD %DESTINATION%\%TIMESTAMP%
	GOTO FULL
) ELSE (
	MD %DESTINATION%\%TIMESTAMP%
	GOTO INCREMENTAL
)

:FULL
ECHO Full-Backup
rsync -aE --inplace sourceFolderPath targetFolderPath/isoTimestamp
REM Full-Backup
EXIT /B

:INCREMENTAL
ECHO Incremental-Backup
rsync -aE --delete --link-dest=lastFolderPath sourceFolderPath targetFolderPath/isoTimestamp
REM Incremental-Backup
EXIT /B

:END

ENDLOCAL

