@echo off
echo This script enforces the use of security key sign-in by disabling other sign-in methods.
echo This will disable password, PIN, picture password, and other sign-in options.
echo This is a permanent change and will require a security key to sign in.
echo To restore the previous sign-in options, you'll need to run the allow-all-sign-in-methods.cmd script. 
echo: This may require offline access with a Windows USB tool and, in some cases, the BitLocker Recovery key.
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

REM Disable Password Provider
REM This disables the regular password login option.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{60b78e88-ead8-445c-9cfd-0b87f74ea6cd}" /v Disabled /t REG_DWORD /d 1 /f

REM Disable NGC Credential Provider
REM This disables the PIN login option along with other Windows Hello functionalities.
REM Note: Disabling NGC is critical to effectively disable PIN sign-in.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{D6886603-9D2F-4EB2-B667-1971041FA96B}" /v Disabled /t REG_DWORD /d 1 /f

REM Disable Additional Windows Hello Providers (Iris, Face, WinBio)
REM These are for disabling other biometric options like iris and facial recognition.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{C885AA15-1764-4293-B82A-0586ADD46B35}" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{8AF662BF-65A0-4D0A-A540-A338A999D36F}" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{BEC09223-B018-416D-A0AC-523971B639F5}" /v Disabled /t REG_DWORD /d 1 /f

REM Disable Picture Password Provider
REM This disables the picture password login option.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{2135f72a-90b5-4ed3-a7f1-8bb705ac276a}" /v Disabled /t REG_DWORD /d 1 /f

REM Disable Smart Card Providers
REM These disable various smart card login options.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{1b283861-754f-4022-ad47-a5eaaa618894}" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{1ee7337f-85ac-45e2-a23c-37c753209769}" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{8FD7E19C-3BF7-489B-A72C-846AB3678C96}" /v Disabled /t REG_DWORD /d 1 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\Credential Providers\{94596c7e-3744-41ce-893e-bbf09122f76a}" /v Disabled /t REG_DWORD /d 1 /f

echo Credential providers modification completed.
pause

popd
