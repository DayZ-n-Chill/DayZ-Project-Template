@echo off
SETLOCAL
:: Load variables from Globals.cfg and set them with quoted values
:: Uncomment the below code if you plan to run this on your own and not just with the start.bat
:: for /f "tokens=1* delims== eol=#" %%i in (..\..\Shared\Globals.cfg) do (
::     set "%%i=%%j"
:: )

REM Check if the P drive is mounted
IF NOT EXIST "%PDRIVE%" (
    powershell -Command "Write-Host 'WARNING: The P drive is not mounted. Please ensure it is mounted and restart the setup.' -ForegroundColor Red"
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
    powershell -Command "Write-Host 'SUCCESS:' -ForegroundColor Green -NoNewline; Write-Host ' P:\Mods\' -ForegroundColor Cyan -NoNewline; Write-Host ' already exists, Carry On!' -ForegroundColor Green -NoNewline;"
    echo. 

) ELSE (
    echo.
    powershell -Command "Write-Host 'Junction created successfully.' -ForegroundColor Green"
    powershell -Command "Write-Host 'Workshop mods are linked to' -ForegroundColor Green -NoNewline; Write-Host ' "%MODDIR%" ' -ForegroundColor Cyan -NoNewline; Write-Host 'on the P drive.' -ForegroundColor Green;"
)

ENDLOCAL

