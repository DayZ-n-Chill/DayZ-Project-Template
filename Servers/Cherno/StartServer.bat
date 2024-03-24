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
::  User Configuration
:: ====================================================================================================================
SET "PROJECTDIR=E:\2024 Projects\DayZ Projects\DayZ-Project-Template"
SET "GAMEDIR=C:\Program Files (x86)\Steam\steamapps\common\DayZ"
:: These mods are mods you use on all your servers.  Could be a server pack, or whatever. 
CALL "%PROJECTDIR%\Utils\Globals.bat"
:: These mods are specific only to this server instanace. 
SET "MODS=P:\Mods\Mod-Name;"

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
start /D "%GAMEDIR%\" DayZDiag_x64.exe "-mod=%GLOBALMODS%%MODS%" -filePatching -server "-profiles=%PROFILES%" "-mission=%MISSIONDIR%" "-config=%SERVERCFG%" 
:: Play on local server.
start /D "%GAMEDIR%\" DayZDiag_x64.exe "-profiles=%CLIENTLOGSDIR%" "-mod=%GLOBALMODS%%MODS%" -filePatching -connect=127.0.0.1 -port=2302 
