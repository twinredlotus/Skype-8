$SkypeSetup = "$env:USERPROFILE\AppData\Roaming\Microsoft\Skype for Desktop\Skype-Setup.exe" #Creates alias for Skype-Setup.exe location. If exists, this will be deleted and replaced with false executable.
If (Test-Path "$SkypeSetup") #If Path exists, delete it. Create new directory in place of update executable. 
	{
	Write-Output "Removing Skype Update Executable: $SkypeSetup"
	Remove-Item -Force -Path "$SkypeSetup"
	}
	Write-Output "Creating Flase Update Executable: $SkypeSetup"
	New-Item -ItemType "Directory" -Path $SkypeSetup