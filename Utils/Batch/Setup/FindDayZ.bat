@echo off
setlocal EnableDelayedExpansion

:: Retrieve the main Steam installation path from the registry
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v "SteamPath"') do set "SteamPath=%%b"

:: Normalize the path by replacing slashes
set "SteamPath=!SteamPath:\=/!"

:: Assume DayZ could be in the default location
set "DayZDir=!SteamPath!/steamapps/common/DayZ"

:: Check if DayZ is installed in the default directory
if exist "!DayZDir!" (
    echo Found DayZ at: !DayZDir!
    goto DisplayPath
) else (
    echo Checking additional library folders...

    :: Read additional library paths from libraryfolders.vdf and check each
    for /f "delims=" %%l in ('type "!SteamPath!\steamapps\libraryfolders.vdf" 2^>nul ^| findstr /i "path"') do (
        set "line=%%l"
        set "line=!line:*"path"=!"
        for /f "delims=" %%p in ("!line!") do set "libPath=%%~p"
        set "libPath=!libPath:\\=\!"
        set "libPath=!libPath:/=\!"
        set "libPath=!libPath:"=!"

        :: Check if DayZ is in this library folder
        if exist "!libPath!\steamapps\common\DayZ" (
            set "DayZDir=!libPath!\steamapps\common\DayZ"
            echo Found DayZ at: !DayZDir!
            goto DisplayPath
        )
    )
    echo DayZ not found in any configured library.
    goto EndScript
)

:DisplayPath
:: Output the installation directory
echo Installation Directory: !DayZDir!

:EndScript
pause
endlocal
