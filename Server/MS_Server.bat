@echo off
title
color 0A

REM Admin and Guest
net user administrator /active:no
net user guest /active:no
REM Firewall
netsh advfirewall set allprofiles state on
REM Telnet
DISM /online /disable-feature /featurename:TelnetClient
DISM /online /disable-feature /featurename:TelnetServer
sc stop "TlntSvr"
sc config "TlntSvr" start= disabled
REM Remote Desktop
sc stop "TermService"
sc config "TermService" start= disabled
sc stop "SessionEnv"
sc config "SessionEnv" start= disabled
sc stop "UmRDPService"
sc config "UmRDPService" start= disabled
sc stop "RemoteRegistry"
sc config "RemoteRegistry" start= disabled
sc stop "Remote Procedure Protocol (RPC)"
sc config "RemoteRegistry" start= disabled