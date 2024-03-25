@echo off
setlocal
:: Load variables from Globals.cfg, set them with values quoted, and echo the command
for /f "tokens=1* delims== eol=#" %%i in (..\..\Utils\Shared\Globals.cfg) do (
    set "%%i=%%j"
)
:: ====================================================================================================================
::  DayZ Mod Manager & Server Launcher by: DayZ n' Chill v2.0
:: ====================================================================================================================
::  This script efficiently manages DayZ mods and facilitates launching a DayZ Diagnostic Server.
::  It achieves this by creating necessary junction points for mods, establishing links, and then initiating the server.
::  The primary aim of this script is to simplify mod and server management, especially for users who may not be
::  experienced modders or developers.
::
::  Based on the lessons taught on https://community.bistudio.com/wiki/DayZ:Modding_Basics,
::  as well as https://community.bistudio.com/wiki/DayZ:Workbench_Script_Debugging 

:: ====================================================================================================================
::  Server Mod Configuration
:: ====================================================================================================================
:: These mods are specific only to this server instanace. 
SET "MODS=P:\Mod-Name;"

echo GAMEDIR: %GAMEDIR%
echo WORKDIR: %WORKDIR%
echo PROJECTDIR: %PROJECTDIR%
echo PDRIVE: %PDRIVE%
echo MODDIR: %MODDIR% 
echo MODS: %MODS%

:: ====================================================================================================================
::  Cherno Specific Variables.  
::  NO NEED TO MODIFY ANYTHING ELSE, UNLESS YOU KNOW WHAT YOU'RE DOING!!!
:: ====================================================================================================================
SET "MISSIONDIR=%PROJECTDIR%\Missions\Vanilla\dayzOffline.chernarusplus"
SET "EXPMISSIONDIR=%PROJECTDIR%\Missions\Experimental\dayzOffline.chernarusplus"
SET "CLIENTLOGSDIR=%PROJECTDIR%\Servers\!ClientDiagLogs"
SET "SERVERCFG=%PROJECTDIR%\Servers\Cherno\serverDZ.cfg"
SET "PROFILES=%PROJECTDIR%\Servers\Cherno\Profiles"

:: ====================================================================================================================
::  Server and Game Initialization
::  You can change the -mission=%MISSIONDIR%" Variable with -mission=%EXPMISSIONDIR%" to use Experimental Mission
::
::  BUT AGAIN, NO NEED TO MODIFY ANYTHING ELSE, UNLESS YOU KNOW WHAT YOU'RE DOING!!!
:: ====================================================================================================================
:: Start Cherno server.
start /D "%GAMEDIR%\" DayZDiag_x64.exe "-mod=%GLOBALMODS%%MODS%" -filePatching -server "-profiles=%PROFILES%" -mission=%MISSIONDIR% "-config=%SERVERCFG%" 
:: Play on local server.
@REM start /D "%GAMEDIR%\" DayZDiag_x64.exe "-profiles=%CLIENTLOGSDIR%" "-mod=%GLOBALMODS%%MODS%" -filePatching -connect=127.0.0.1 -port=2302 
