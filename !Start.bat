@echo off

REM Define the target drive letter
set "drive=P:\"

:check_drive
REM Check if the specified drive exists
if not exist %drive% (
    set /p "drive=Enter Drive Letter (P:\): "
    goto check_drive
)

REM Loop through each subdirectory in the current directory
for /d %%D in (*) do (
    REM Check if the Workbench directory exists within the subdirectory
    if exist "%%D\Workbench\dayz.gproj" (
        REM Create the junction
        mklink /j "%drive%%%~nxD" "%%D\Workbench"
        echo Created junction for "%%D" to "%drive%%%~nxD"
    )
)

echo Done.
