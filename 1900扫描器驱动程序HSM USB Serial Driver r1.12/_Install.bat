@echo off
@rem **********************************************************************************
@rem 
@rem HSM USB Serial Driver Installation Batch File
@rem 
@rem Version:
@rem 	1.2
@rem
@rem Usage:
@rem 	_install.bat [/Arg] [HSMUSD_DRIVERPATH]
@rem 
@rem Arg:
@rem	/i to install control, enum and cdc drivers 
@rem	/p to preinstall control, enum and cdc and rescan USB
@rem 	/u to uninstall control enum and cdc drivers
@rem	/si to install control, enum and cdc drivers, silent mode
@rem	/sp to preinstall control, enum and cdc and rescan USB, silent mode
@rem 	/su to uninstall control enum and cdc drivers, silent mode
@rem
@rem Examples:
@rem    _install /i .\x86   	'install control 
@rem    _install /p .\x86	'install control and pre-install enum and cdc 
@rem    _install /u 		'uninstall all 
@rem
@rem Defaults (override defaults by seting the following environmental vars or using command line args):
@rem    HSMUSD_ACTION- 'install' to install (control only), 'preinstall' to install control and pre-install enum and cdc, 
@rem 			'uninstall' to uninstall
@rem    HSMUSD_DRIVERPATH - Path to the driver
@rem 	HSMUSD_WDREGEXE - Name of wdreg util, wreg.exe or wdreg_gui.exe 
@rem 	HSMUSD_SILENT - Set to 'silent' to specify silent install
@rem
@rem **********************************************************************************


@rem **********************************************************************************
@rem If environmental vars are not set, set them to defaults
@rem **********************************************************************************
set HSMUSD_VER=1.2
if ""%HSMUSD_WDREGEXE%""=="""" set HSMUSD_WDREGEXE=wdreg.exe
if ""%HSMUSD_DRIVERPATH%""=="""" set HSMUSD_DRIVERPATH=.\x86
if ""%HSMUSD_ACTION%""=="""" set HSMUSD_ACTION=preinstall
if ""%HSMUSD_SILENT%""=="""" set HSMUSD_SILENT=
if ""%HSMUSD_CAPTURESETUPAPILOG%""=="""" set HSMUSD_CAPTURESETUPAPILOG=1
if ""%HSMUSD_RESCAN%""=="""" set HSMUSD_RESCAN=1

@rem **********************************************************************************
@rem Process command line args
@rem **********************************************************************************

@rem Check command line args
if ""%1""=="""" goto COMMANDLINEOK
if ""%1""==""/i"" goto COMMANDLINEOK
if ""%1""==""/u"" goto COMMANDLINEOK
if ""%1""==""/p"" goto COMMANDLINEOK
if ""%1""==""/si"" goto COMMANDLINEOK
if ""%1""==""/su"" goto COMMANDLINEOK
if ""%1""==""/sp"" goto COMMANDLINEOK
@echo Command line (%1) incorrect, validate the options are correct and re-run the install.
goto END
:COMMANDLINEOK

@rem Make sure to reset environmental vars when command line changes incase user runs command multible time from the same 
@rem command prompt

if ""%1""=="""" goto DONESETARGS
if ""%1""==""/i"" set HSMUSD_ACTION=install
if ""%1""==""/u"" set HSMUSD_ACTION=uninstall
if ""%1""==""/p"" set HSMUSD_ACTION=preinstall
if ""%1""==""/i"" set HSMUSD_RESCAN=0
if ""%1""==""/u"" set HSMUSD_RESCAN=0
if ""%1""==""/p"" set HSMUSD_RESCAN=1
if ""%1""==""/i"" set HSMUSD_SILENT=
if ""%1""==""/u"" set HSMUSD_SILENT=
if ""%1""==""/p"" set HSMUSD_SILENT=
if ""%1""==""/i"" set HSMUSD_WDREGEXE=wdreg.exe
if ""%1""==""/u"" set HSMUSD_WDREGEXE=wdreg.exe
if ""%1""==""/p"" set HSMUSD_WDREGEXE=wdreg.exe
if ""%1""==""/si"" set HSMUSD_ACTION=install
if ""%1""==""/su"" set HSMUSD_ACTION=uninstall
if ""%1""==""/sp"" set HSMUSD_ACTION=preinstall
if ""%1""==""/si"" set HSMUSD_RESCAN=0
if ""%1""==""/su"" set HSMUSD_RESCAN=0
if ""%1""==""/sp"" set HSMUSD_RESCAN=1
if ""%1""==""/si"" set HSMUSD_SILENT=-silent
if ""%1""==""/su"" set HSMUSD_SILENT=-silent
if ""%1""==""/sp"" set HSMUSD_SILENT=-silent

@rem Appears wdreg.exe may output a header even when silent is specified so use wdreg_gui.exe for silent operation
if ""%1""==""/si"" set HSMUSD_WDREGEXE=wdreg_gui.exe
if ""%1""==""/su"" set HSMUSD_WDREGEXE=wdreg_gui.exe
if ""%1""==""/sp"" set HSMUSD_WDREGEXE=wdreg_gui.exe

if ""%2""=="""" goto DONESETARGS
set HSMUSD_DRIVERPATH=%2
:DONESETARGS

@rem **********************************************************************************
@rem Check Driver Location
@rem **********************************************************************************
if exist "%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" goto DRIVERPATHOK
@echo Driver path (%HSMUSD_DRIVERPATH%) incorrect, validate the path is correct and re-run the install.
goto END
:DRIVERPATHOK

@rem **********************************************************************************
@rem Run wdreg.exe based on the action specified
@rem **********************************************************************************
if ""%HSMUSD_ACTION%""==""install"" goto INSTALL
if ""%HSMUSD_ACTION%""==""preinstall"" goto PREINSTALL
if ""%HSMUSD_ACTION%""==""uninstall"" goto UNINSTALL
@echo Action (%HSMUSD_ACTION%) incorrect, validate the options are correct and re-run the install.
goto END

@rem **********************************************************************************
@rem Install/Preinstall driver
@rem **********************************************************************************
:PREINSTALL
:INSTALL
@set LOGFILE=.\Install.log
if exist %LOGFILE% del %LOGFILE%
@echo. > %LOGFILE%

@set DRIVER_VER_FILE="%USERPROFILE%\HSM_USB_Serial_Driver_Version.txt"
if exist %DRIVER_VER_FILE% del %DRIVER_VER_FILE%
@echo. > %DRIVER_VER_FILE%
@echo **************************************************************************** >> %DRIVER_VER_FILE%
@echo HSM USB Serial Driver r1.12 installed - %date% %time% >> %DRIVER_VER_FILE%
@echo **************************************************************************** >> %DRIVER_VER_FILE%

@echo ************************************************************ >> %LOGFILE%
@echo WDREG LOG - %date% %time% >> %LOGFILE%
@echo ************************************************************ >> %LOGFILE%
@echo HSMUSD_VER=%HSMUSD_VER% >> %LOGFILE%
@echo ARG[1]=%1 >> %LOGFILE%
@echo ARG[2]=%2 >> %LOGFILE%
@echo HSMUSD_WDREGEXE=%HSMUSD_WDREGEXE% >> %LOGFILE%
@echo HSMUSD_DRIVERPATH=%HSMUSD_DRIVERPATH% >> %LOGFILE%
@echo HSMUSD_ACTION=%HSMUSD_ACTION% >> %LOGFILE%
@echo HSMUSD_SILENT=%HSMUSD_SILENT% >> %LOGFILE%
@echo HSMUSD_INSTALLCONTROL=%HSMUSD_INSTALLCONTROL% >> %LOGFILE%
@echo HSMUSD_INSTALLENUM=%HSMUSD_INSTALLENUM% >> %LOGFILE%
@echo HSMUSD_INSTALLCDC=%HSMUSD_INSTALLCDC% >> %LOGFILE%
@echo HSMUSD_CAPTURESETUPAPILOG=%HSMUSD_CAPTURESETUPAPILOG% >> %LOGFILE%
@echo HSMUSD_RESCAN=%HSMUSD_RESCAN% >> %LOGFILE%

@rem Force 'install' (not 'preinstall') on honeywell_enum_control_???, it is not PNP so it will not be installed if
@rem 'preinstall' is used.

for /f "delims=|" %%f in ('dir /b "%HSMUSD_DRIVERPATH%\honeywell_enum_control.inf"') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log "%LOGFILE%" install
 
@rem No need to install or preinstall enum or cdc *999.inf, *999.infs are not WHQL certified.   Non WHQL certified enum and  
@rem cdc drivers can not be preinstalled and need to be install when the device is connected.  

for /f "delims=|" %%f in ('dir /b "%HSMUSD_DRIVERPATH%\honeywell_enum.inf"') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log "%LOGFILE%" %HSMUSD_ACTION%

for /f "delims=|" %%f in ('dir /b "%HSMUSD_DRIVERPATH%\honeywell_cdc.inf"') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log "%LOGFILE%" %HSMUSD_ACTION%

goto SKIPUNINSTALL

@rem **********************************************************************************
@rem Uninstall driver
@rem **********************************************************************************
:UNINSTALL
@set LOGFILE=.\Uninstall.log
if exist %LOGFILE% del %LOGFILE%
@set DRIVER_VER_FILE="%USERPROFILE%\HSM_USB_Serial_Driver_Version.txt"
if exist %DRIVER_VER_FILE% del %DRIVER_VER_FILE%
@echo. > %LOGFILE%

@echo ************************************************************ >> %LOGFILE%
@echo WDREG LOG - %date% %time% >> %LOGFILE%
@echo ************************************************************ >> %LOGFILE%
@echo HSMUSD_VER=%HSMUSD_VER% >> %LOGFILE%
@echo ARG[1]=%1 >> %LOGFILE%
@echo ARG[2]=%2 >> %LOGFILE%
@echo HSMUSD_WDREGEXE=%HSMUSD_WDREGEXE% >> %LOGFILE%
@echo HSMUSD_DRIVERPATH=%HSMUSD_DRIVERPATH% >> %LOGFILE%
@echo HSMUSD_ACTION=%HSMUSD_ACTION% >> %LOGFILE%
@echo HSMUSD_SILENT=%HSMUSD_SILENT% >> %LOGFILE%
@echo HSMUSD_INSTALLCONTROL=%HSMUSD_INSTALLCONTROL% >> %LOGFILE%
@echo HSMUSD_INSTALLENUM=%HSMUSD_INSTALLENUM% >> %LOGFILE%
@echo HSMUSD_INSTALLCDC=%HSMUSD_INSTALLCDC% >> %LOGFILE%
@echo HSMUSD_CAPTURESETUPAPILOG=%HSMUSD_CAPTURESETUPAPILOG% >> %LOGFILE%
@echo HSMUSD_RESCAN=%HSMUSD_RESCAN% >> %LOGFILE%

for /f "delims=|" %%f in ('dir /b %HSMUSD_DRIVERPATH%\honeywell_cdc.inf') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log %LOGFILE% %HSMUSD_ACTION%

for /f "delims=|" %%f in ('dir /b %HSMUSD_DRIVERPATH%\honeywell_enum.inf') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log %LOGFILE% %HSMUSD_ACTION%

for /f "delims=|" %%f in ('dir /b %HSMUSD_DRIVERPATH%\honeywell_enum_control.inf') do ^
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -inf "%HSMUSD_DRIVERPATH%\%%f" %HSMUSD_SILENT% -log %LOGFILE% %HSMUSD_ACTION%

:SKIPUNINSTALL

@rem **********************************************************************************
@rem Rescan, needed if driver is preinstall and device is already connected.   Much faster to preinstall and rescan 
@rem than to install, install searches for every device in inf.
@rem **********************************************************************************
if ""%HSMUSD_RESCAN%""==""0"" GOTO SKIPHSMUSDRESCAN
"%HSMUSD_DRIVERPATH%\%HSMUSD_WDREGEXE%" -rescan USB %HSMUSD_SILENT% -log %LOGFILE% %HSMUSD_ACTION%
:SKIPHSMUSDRESCAN

@rem **********************************************************************************
@rem Copy SetupAPI log to install/uninstall log
@rem **********************************************************************************
if ""%HSMUSD_CAPTURESETUPAPILOG%""==""0"" GOTO END
@echo. >> %LOGFILE% 
if exist "%SystemRoot%\setupapi.log" @echo ************************************************************ >> %LOGFILE%
if exist "%SystemRoot%\setupapi.log" @echo SETUPAPI LOG >> %LOGFILE%
if exist "%SystemRoot%\setupapi.log" @echo ************************************************************ >> %LOGFILE%
if exist "%SystemRoot%\inf\setupapi.dev.log" @echo ************************************************************ >> %LOGFILE%
if exist "%SystemRoot%\inf\setupapi.dev.log" @echo SETUPAPI LOG >> %LOGFILE%
if exist "%SystemRoot%\inf\setupapi.dev.log" @echo ************************************************************ >> %LOGFILE%
if exist "%SystemRoot%\setupapi.log" @type %SystemRoot%\setupapi.log >> %LOGFILE%
if exist "%SystemRoot%\inf\setupapi.dev.log" @type %SystemRoot%\inf\setupapi.dev.log >> %LOGFILE%


:END