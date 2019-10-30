 #############################################################################
# Author  : sotaloss
# Website : www.eskonr.com
# Blog : http://blog.livedoor.jp/sccmsota/
# Created : 30/10/2019
# Purpose : This script will help you fix Windows10 WindowsUpdate errors.
#############################################################################

# Relaunch the script with administrator privileges
Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass"
		Exit
	}
}

# Stop Service
net stop usosvc
net stop ccmexec
net stop wuauserv
net stop bits

# Rename SoftwareDistribution Folder
$Old = (Test-Path "C:\Windows\SoftwareDistribution.old")
if($Old){
    Remove-Item -LiteralPath "C:\Windows\SoftwareDistribution.old" -Force -Recurse
    Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old
}else{
	Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old
}

# Delete BITS-Job folder
Remove-Item -LiteralPath "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\*" -Force -Recurse

# Start Service
net start usosvc
net start ccmexec
net start wuauserv
net start bits