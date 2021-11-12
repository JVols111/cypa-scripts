@echo off
title
color 0A

REM Admin and Guest
net user administrator /active:no
net user guest /active:no
REM Firewall
netsh advfirewall set allprofiles state on
netsh advfirewall firewall set rule name="Remote Assistance (DCOM-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (PNRP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (RA Server TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (SSDP TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (SSDP UDP-In)" new enable=no 
netsh advfirewall firewall set rule name="Remote Assistance (TCP-In)" new enable=no 
netsh advfirewall firewall set rule name="Telnet Server" new enable=no 
netsh advfirewall firewall set rule name="netcat" new enable=no
REM Auditing
auditpol /set /category:* /success:enable
auditpol /set /category:* /failure:enable
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
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
REM Chocolatey
choco install malwarebytes -y
choco install firefox -y
