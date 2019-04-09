# Uninstalls current version of Skype on computer. 

$AppName = "Skype*" 
$CurrentVersion = 9 # Modify to fit current deployed version.

Get-Process | Where-Object {$_.Name -contains "Skype"} | Stop-Process -Force -Verbose # End all processes containing the name Skype.

ForEach ( $Architecture in "SOFTWARE", "SOFTWARE\Wow6432Node" ) 
{ 
	$UninstallKeys = "HKLM:\$Architecture\Microsoft\Windows\CurrentVersion\Uninstall"
	If (Test-Path $UninstallKeys)
	{
		$AppUninstall = Get-ItemProperty -Path "$UninstallKeys\*" | Where-Object { ($_.DisplayName -like "Skype*") -and ($_.DisplayVersion -lt $CurrentVersion) } # Find registry key for Skype version < #CurrentVersion
		$AppUninstallString = $AppUninstall | Select-Object UninstallString -ExpandProperty UninstallString
		
		If ($AppUninstall -ne $null) {
			$AppUninstallString | ForEach-Object {
				Write-Output "`r`nUninstalling: $($AppUninstall.DisplayName)"
				Start-Process -NoNewWindow -FilePath "$AppUninstallString" -ArgumentList " /SILENT" #Uninstall using uninstall string in the registry.
			}
		} Else {
			Write-Output "`r`n$AppName installation not found in: $UninstallKeys"
		}
	}
}