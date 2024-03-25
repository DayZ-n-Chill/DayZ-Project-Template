@echo off
SETLOCAL EnableDelayedExpansion

:: Show the DayZ n Chill Dev Logo.
SET "ASCIIARTPATH=.\Utils\Shared\dznc.txt"
SET "COLORS=Blue,Green,Cyan,DarkBlue,DarkGreen,DarkCyan"
powershell -Command "$colors = '%COLORS%'.Split(','); $randomColor = Get-Random -InputObject $colors; $content = Get-Content -Path '%ASCIIARTPATH%'; $content | ForEach-Object {Write-Host $_ -ForegroundColor $randomColor}"

:: Start Setup
echo This setup file will help you configure your project with ease so you should only have to do this once. 
echo Please follow along with the prompts and you will be ready to go in no time at all. 
echo.
pause

:: Detect the directory of this batch file
SET "DETECTEDDIR=%~dp0"

:: Ask the user if this directory should be the new PROJECTDIR
echo.
echo This should be the directory where you downloaded, or cloned the dayz-project-template from GitHub.
powershell -Command  "Write-Host 'PROJECT DIRECTORY:' -ForegroundColor DarkMagenta -NoNewline; Write-Host ' %DETECTEDDIR%' -ForegroundColor Cyan;"

:: Define the message string
SET "MESSAGE=Please verify that this is your Project's Location?"
:: Display the message with parentheses in yellow using PowerShell
echo.
powershell -Command "$message = 'Please verify that this is your Project''s location listed above?'; Write-Host -ForegroundColor Yellow -NoNewline $message; Write-Host ' (Y/N)' -NoNewline;"

set /p USERCONFIRM=

if /i "%USERCONFIRM%" neq "Y" (
    echo.
    echo Please enter the path to your project directory manually:
    set /p NEWPROJECTDIR=
    echo.
    powershell -Command "Write-Host 'SET PROJECTDIR to: !NEWPROJECTDIR! in Global.cfg ' -ForegroundColor Cyan"
) else (
    SET "NEWPROJECTDIR=%DETECTEDDIR%"
    echo.
    powershell -Command "Write-Host 'SET PROJECTDIR to: !NEWPROJECTDIR! in Global.cfg ' -ForegroundColor Blue"
)

:: Remove trailing backslash from PROJECTDIR if it exists
if "%NEWPROJECTDIR:~-1%"=="\" (
    SET "NEWPROJECTDIR=%NEWPROJECTDIR:~0,-1%"
)

:: Create a temporary file for the updated configuration
SET "TEMPCFGFILE=%TEMP%\temp_globals.cfg"
if exist "%TEMPCFGFILE%" del "%TEMPCFGFILE%"

(for /f "tokens=1* delims==" %%i in (./Utils/Shared/Globals.cfg) do (
    if "%%i"=="PROJECTDIR" (
        echo PROJECTDIR=!NEWPROJECTDIR!>> "%TEMPCFGFILE%"
    ) else (
        for /f "delims=" %%a in ("%%i") do (
            set "line=%%a"
            if "!line:~0,1!"=="#" (
                echo %%a>> "%TEMPCFGFILE%"
            ) else (
                echo %%i=%%j>> "%TEMPCFGFILE%"
            )
        )
    )
)) >nul

:: Replace the original Globals.cfg with the updated one
move /y "%TEMPCFGFILE%" "./Utils/Shared/Globals.cfg" >nul

powershell -Command "Write-Host 'PROJECTDIR updated successfully.' -ForegroundColor Green"
echo. 
powershell -Command "Write-Host 'Setup is Complete.' -ForegroundColor Green"
timeout /t 5 /nobreak 
exit
