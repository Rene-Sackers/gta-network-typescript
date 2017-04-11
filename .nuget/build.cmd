@echo off
SET OUTPUTDIR="packages"
SET REVISION=""
SET MAJOR=""
SET MINOR=""
SET NUSPECFILE="types-gtanetwork.nuspec"
:checkparameters
:: REM Grab the first variable supplied as a whole. Ex. /action:start
set SWITCHPARSE=%1
:: REM Check to see if there are no more switches, if so goto end of 
:: parsing, prevents endless loop
IF [%SWITCHPARSE%] == [] goto end
REM :: REM Reset variables as clean up. Dont know if i need this anymore
REM :: since i am checking for exit above. Oh well.
REM set SWITCH=
REM set VALUE=
:: In the SWITCHPARSE variable, grab the two tokens separated 
:: by a : and assign the first to SWITCH and the second to VALUE
for /F "tokens=1,2 delims=:" %%a IN ("%SWITCHPARSE%") DO (
	SET SWITCH=%%a
	set VALUE=%%b
)
:: Check which action to perform based on the switch
IF [%SWITCH%] == [/revision] goto setaction
IF [%SWITCH%] == [/major] goto setsysservicename
IF [%SWITCH%] == [/minor] goto setservername
IF [%SWITCH%] == [/outputdir] goto setpassedusername
:: Perform the action by setting the variable for later use and 
:: shift the command line parameters so the next in line is 
:: ready to be processed

goto end

:setaction
set REVISION=%VALUE%
SHIFT
goto checkparameters

:setsysservicename
set MAJOR=%VALUE%
SHIFT
goto checkparameters

:setservername
set MINOR=%VALUE%
SHIFT
goto checkparameters

:setpassedusername
set OUTPUTDIR=%VALUE%
SHIFT
goto checkparameters


:end
echo.
echo PowerShell -NoProfile -ExecutionPolicy Bypass -File "IncrementNugetVersionNumber.ps1" -NuspecFile %NUSPECFILE% -RevisionVersion %REVISION% -MajorVersion %MAJOR% -MinorVersion %MINOR%
PowerShell -NoProfile -ExecutionPolicy Bypass -File "IncrementNugetVersionNumber.ps1" -NuspecFile %NUSPECFILE% -RevisionVersion %REVISION% -MajorVersion %MAJOR% -MinorVersion %MINOR%

echo.
echo nuget pack -OUTPUTDIR "%OUTPUTDIR%"
nuget pack -OUTPUTDIR %OUTPUTDIR%

echo.
echo Done

pause