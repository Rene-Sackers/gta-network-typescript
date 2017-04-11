@echo off

set version=%1
if [%version%] neq [] goto askPublish
set /P version="Version: "

:askPublish

set /P c=Are you sure you want to publish version %version%? [Y/N] 
if /I "%c%" EQU "Y" goto :publish
if /I "%c%" EQU "N" goto :exitCommand

:publish
nuget push packages/types-gtanetwork.%version%.nupkg -Source https://www.nuget.org/api/v2/package

pause
exit

:exitCommand
echo publish canceled

pause