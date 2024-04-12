@echo off
SETLOCAL
:: Load variables from Globals.cfg and set them with quoted values
for /f "tokens=1* delims== eol=#" %%i in (..\..\..\Utils\Shared\Globals.cfg) do (
    set "%%i=%%j"
)

REM Check if the P drive is mounted
IF NOT EXIST "P:\" (
    powershell -Command "Write-Host 'WARNING: The P drive is not mounted. Please ensure it is mounted before continuing.' -ForegroundColor Red"
    pause
    exit /b
)

REM Check if the Workshop directory exists
IF NOT EXIST "%WORKDIR%" (
    powershell -Command "Write-Host 'WARNING: The Workshop directory provided does not exist ' -ForegroundColor Red"
    echo Provided Folder: "%WORKDIR%".
    echo Please make sure the Workshop folder is located there.
    pause
    exit /b
)

REM Create a junction from the Workshop directory to the target directory on the P drive
mklink /J "%MODDIR%" "%WORKDIR%"

REM Check if the junction was created successfully
IF ERRORLEVEL 1 (
    powershell -Command "Write-Host 'WARNING: P:\Mods\ already exists, Carry On!' -ForegroundColor Magenta"
) ELSE (
    powershell -Command "Write-Host 'Junction created successfully.' -ForegroundColor Green"
    echo Workshop mods are linked to "%MODDIR%" on the P drive.
)

ENDLOCAL
pause
