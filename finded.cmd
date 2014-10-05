@echo off

REM Batch parameters
REM %1 => Mandatory path to a directory
REM %2 => An optional callback, executed for any empty directory

if [%1] == [] (
	goto USAGE
)

for /f "usebackq delims=" %%F in (`dir /a:d /s /b %1 ^| "%WINDIR%\System32\sort" /r`) do (

	REM HACK: The DIR command with /A option always finds the current and parent 
	REM directories respectively. Therefore one cannot check the %ERRORLEVEL% 
	REM for emptiness of a directory. So the FINDSTR command just looks for any 
	REM or none output to determine whether a directory is empty or not.
	dir /a /b "%%F" | findstr "^.*$" > nul && (
	
		REM Files and/or Folders exist
		REM %ERRORLEVEL% is 0
	) || (
		REM No File or Folder found
		REM %ERRORLEVEL% is 1
		
		if not [%2] == [] (
			REM Execute callback argument
			echo %~2
			%~2
		) else (
			REM Just print the path to the empty directory
			echo %%F
		)
	)
)
goto EOF

:USAGE
echo.
echo Recursive search for empty directories, 
echo with optional callback for each occurrence.
echo.
echo USAGE: %~n0 ^<DIR^> [CALLBACK]
echo.
echo EXAMPLES:	finded C:\
echo			finded C:\GitHub "copy /y nul ^"%%F\.gitkeep^^""
echo.

:EOF
