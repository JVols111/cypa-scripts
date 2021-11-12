@echo off
title
color 0A

REM Remote Registry
sc stop remoteregistry
REM Remove Software
wmic product where name=<software> call uninstall
REM Remove User
net user <username> /delete
REM Remove User From Administrator Group
net localgroup administrators <username> /delete
REM Change Password
net user <username> Password@123
REM Password Policy
net accounts /lockoutthreshold:5 /MINPWLEN:8 /MAXPWAGE:90 /MINPWAGE:10 /UNIQUEPW:5 /lockoutduration:30 /lockoutduration:30
REM Update Firefox
%INSTALLDIR%\Mozilla Firefox\updater.exe -ms
REM Delete MP3 And MP4 Files
del /s c:\*.mp3
del /s c:\*.mp4
REM Require Ctrl+Alt+Del
reg add HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Policies/System /v DisableCAD /d 0 /f
