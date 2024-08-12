@ECHO off
cls
:start
ECHO.
ECHO 1. Change 192.168.8.250 Static IP 
ECHO 2. Change "Local Area Connection" to DHCP IP 
ECHO 3. Change 10.37.104.250 Static IP 
ECHO 4. Obtain an IP address automatically
ECHO 5. Exit
set choice=
set /p choice=Type the number to print text.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' goto con1
if '%choice%'=='2' goto con2
if '%choice%'=='3' goto con3
if '%choice%'=='4' goto autosearch
if '%choice%'=='5' goto end
ECHO "%choice%" is not valid, try again
ECHO.
goto start
:con1
ECHO Connecting Connection 1
netsh interface ip set address "Local Area Connection" static 192.168.8.250 255.255.255.0 192.168.8.1 1
goto end

:con2
ECHO Connecting Connection 2
netsh interface ip set address "Local Area Connection" source=dhcp
goto end

:con3
ECHO Connecting Connection 3
netsh interface ip set address "Local Area Connection" static 10.37.104.250 255.255.255.0 10.37.104.1 1
goto end

:autosearch
ECHO obtaining auto IP
ipconfig /renew "Local Area Connection"
goto end

:bye
ECHO BYE
goto end

:end