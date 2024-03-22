::Mods you want to run on the server. 
SET "MODS=P:\Mods\@CF;P:\Mods\@Dabs Framework;P:\Mods\@Community-Online-Tools;"

:: Set the directory to your project.  This is where you cloned your . 
SET "PROJECTDIR=E:\2024 Projects\DayZ Projects\DayZ-Project-Template"

:: Set the Game directory where you have DayZ installed
SET "GAMEDIR=C:\Program Files (x86)\Steam\steamapps\common\DayZ"

:: Set the Client Diagnostic Log directory 
SET "CLIENTLOGSDIR=%PROJECTDIR%\Servers\!ClientDiagLogs"
::NOTE:: !ClientDiagLogs is located in the root of your DayZ installation folder by Default
:: Relpace "-profiles=!ClientDiagLogs" with  "-profiles=%CLIENTLOGSDIR%" on the last line in the bat file.

:: Set Location of Server Profiles Folder
SET "PROFILES=%PROJECTDIR%\Servers\Cherno\Profiles"

:: Server config for Cherno server.
SET "SERVERCFG=%PROJECTDIR%\Servers\Cherno\serverDZ.cfg"

:: Vanilla Mission directory for Cherno server.
SET "MISSIONDIR=%PROJECTDIR%\Missions\Vanilla\dayzOffline.chernarusplus"

:: Experimental Mission directory for Cherno server.
SET "EXPMISSIONDIR=%PROJECTDIR%\Missions\Experimental\dayzOffline.chernarusplus"

:: Start Cherno server.
start /D "%GAMEDIR%\" DayZDiag_x64.exe -server -noPause -doLogs "-mod=%MODS%" "-profiles=%PROFILES%" -battleye=0 -filepatching=1 "-mission=%MISSIONDIR%" "-config=%SERVERCFG%"

:: Play on local server.
start /D "%GAMEDIR%\" DayZDiag_x64.exe "-profiles=%CLIENTLOGSDIR%" "-mod=%MODS%" -filepatching=1 -connect=127.0.0.1 -port=2302 
