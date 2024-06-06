@echo off
echo Enabling sign in with security key, good for testing. Not enforced.
set /p continue=Do you want to continue (Y/N)? 
if /i "%continue%" == "Y" goto :continue
exit

:continue
echo Continuing to enforce security key sign-in...
:: Self-elevate the script if required
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto :gotAdmin ) else ( goto :UACPrompt )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"

REM Enable Security Key Sign in
REG ADD "HKLM\SOFTWARE\policies\Microsoft\FIDO" /v EnableFIDODeviceLogon /t REG_DWORD /d 1 /f

echo Credential providers modification completed.
pause

popd
