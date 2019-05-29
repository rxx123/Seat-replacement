'***********************************************************************************
'Show Off-Line Devices in Device Manager.vbs
'Verion 1.0.0
'
'Windows Registry Editor Version 5.00
'[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment]
'"DEVMGR_SHOW_DETAILS"=dword:00000001
'"DEVMGR_SHOW_NONPRESENT_DEVICES"="1"
'
'History
'3/14/2010 - Initial release
'***********************************************************************************

Option Explicit
On Error Resume Next


'***********************************************************************************
'Pull in global functions
'***********************************************************************************
Dim fsObj : Set fsObj = CreateObject("Scripting.FileSystemObject")
Const ForReading = 1
Dim vbsFile : Set vbsFile = fsObj.OpenTextFile("global.vbs", ForReading, False)
Dim globalfunctions : globalfunctions = vbsFile.ReadAll
vbsFile.Close
Set vbsFile = Nothing
Set fsObj = Nothing
ExecuteGlobal globalfunctions

'***********************************************************************************
'check for elevated privileges
'***********************************************************************************
dim rc : rc=CheckForElevatedPrivileges()
if rc=errElevatedPrivileges then
		MsgBox "Script must be run with Elevated Privileges in Vista " & _
			"or higher.  Execute script again from an Elevated " & _
			"Command Prompt.", vbOK + vbSystemModal, "Warning"
		WScript.Quit errElevatedPrivileges
end if

'Regtype should be “REG_SZ” for string, “REG_DWORD” for a integer,…
'REG_BINARY” for a binary or boolean, and “REG_EXPAND_SZ” for an expandable string
'HKEY_CURRENT_USER = HKCU
'HKEY_LOCAL_MACHINE = HKLM
'HKEY_CLASSES_ROOT = HKCR
'HKEY_USERS = HKEY_USERS
'HKEY_CURRENT_CONFIG = HKEY_CURRENT_CONFIG

Dim objRegistry, bKey, regpath

Set objRegistry = CreateObject("Wscript.shell")
regpath="HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\DEVMGR_SHOW_DETAILS"
bKey = objRegistry.RegWrite(regpath, 1, "REG_DWORD")
regpath="HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\DEVMGR_SHOW_NONPRESENT_DEVICES"
bKey = objRegistry.RegWrite(regpath, "1", "REG_SZ")


MsgBox "Display of off-line devices in Device Mananager enabled.  Select 'View|Show hidden devices' to see off-line devices.  Reboot required for setting to take effect.", 0, "Enabled"


