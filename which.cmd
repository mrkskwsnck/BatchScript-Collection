@ECHO OFF

REM Prints all the occurrences of an argument file with absolute path to STDOUT,
REM if it is present within the %PATH% environment variable. The argument file
REM can be given with or without its file extension. It also works with long and
REM 8.3 file names as well. Consider using double quotes, if the argument
REM contains whitespaces.

SETLOCAL EnableDelayedExpansion

REM Shift the working directory to the %PATH% environment
SET PATH=.;%PATH%

REM Iterate through the path extensions pushed as suffix to the given argument
FOR %%E IN (%PATHEXT%) DO (
	SET FILE=%1%%E
	FOR %%F IN (!FILE!) DO (
		SET WHICH=%%~$PATH:F
		IF DEFINED WHICH (
			ECHO !WHICH!

			REM Exit on first occurrence
			GOTO END
		)
	)
)

REM Look up the path environment for the exactly given argument
SET WHICH=%~$PATH:1
IF DEFINED WHICH ECHO !WHICH!

:END

ENDLOCAL
