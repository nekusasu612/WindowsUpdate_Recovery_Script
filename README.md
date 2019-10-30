# WindowsUpdate_Recovery_Script
This script will help you fix Windows10 WindowsUpdate errors.

# 実施される内容  
1.自動更新サービスと BITS サービスの停止  
net stop usosvc  
net stop ccmexec  
net stop wuauserv  
net stop bits  

2.SoftwareDistribution フォルダーのリネーム  
$Old = (Test-Path "C:\Windows\SoftwareDistribution.old")  
if($Old){  
    Remove-Item -LiteralPath "C:\Windows\SoftwareDistribution.old" -Force -Recurse  
    Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old  
}else{  
	Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old  
}  

3.BITS ジョブを削除  
Remove-Item -LiteralPath "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\*" -Force -Recurse  

4.自動更新サービスとBITS サービスの開始  
net start usosvc  
net start ccmexec  
net start wuauserv  
net start bits  
