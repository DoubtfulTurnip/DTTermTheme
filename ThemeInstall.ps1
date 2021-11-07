<#
Title:  DoubtfulTurnip's Mega-Script
Author: DoubfulTurnip
#>



$banner = @"
                _____
             ,-"     "-.   
            / o       o \
           /   \     /   \
          /     )-"-(     \
         /     ( 6 6 )     \ 
        /       \ " /       \
       /         )=(         \
      /   o   .--"-"--.   o   \
     /    I  /  -   -  \  I    \
 .--(    (_}y/\       /\y{_)    )--.
(    ".___l\/__\_____/__\/l___,"    )
 \                                 /
  "-._      o O o O o O o      _,-"
      `--Y--.___________.--Y--'
         |==.___________.==| 
         `==.___________.==' 

"@



function Start-Backup {
$mydocuments = [environment]::getfolderpath("mydocuments")

$backupfoldercheck = Test-Path "$mydocuments\DTTermTheme\Backups"
	if ($backupfoldercheck -eq $false)
{
Write-Output "The backup folder doesn't exist. Creating this now for you..."
Write-Output ""
Start-Sleep 5
New-Item -Path  "$mydocuments\DTTermTheme\Backups" -ItemType Directory -Force  | Out-Null
New-Item -Path  "$mydocuments\DTTermTheme\Backups\Terminal Profile\" -ItemType Directory -Force  | Out-Null
New-Item -Path  "$mydocuments\DTTermTheme\Backups\PSProfile\" -ItemType Directory -Force  | Out-Null

Copy-Item -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Destination "$mydocuments\DTTermTheme\Backups\Terminal Profile\" -Force
Copy-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -destination "$mydocuments\DTTermTheme\Backups\PSProfile\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item -Path "$env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -destination "$mydocuments\DTTermTheme\Backups\PSProfile\Microsoft.PowerShell_profile-7.ps1" -Force 
}

	else {
		Write-Output "Original backup folder already exists"
		Write-Output ""
		$overwrite = Read-Host "Would you like to create a new backup? (This will not effect your original backup) [Y/N]"
		if ($overwrite -eq 'Y'){
		
		$date = Get-Date
		$date = $date.ToString("yyyy-MM-dd-HH-mm")
		
		New-Item -Path  "$mydocuments\DTTermTheme\Backups\$date" -ItemType Directory -Force | Out-Null
		New-Item -Path  "$mydocuments\DTTermTheme\Backups\$date\Terminal Profile\" -ItemType Directory -Force | Out-Null
		New-Item -Path  "$mydocuments\DTTermTheme\Backups\$date\PSProfile\" -ItemType Directory -Force | Out-Null
		New-Item -Path  "$mydocuments\DTTermTheme\Backups\$date\PoshTheme\" -ItemType Directory -Force | Out-Null
		
		Copy-Item -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Destination "$mydocuments\DTTermTheme\Backups\$date\Terminal Profile\" -Force
		Copy-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -destination "$mydocuments\DTTermTheme\Backups\$date\PSProfile\Microsoft.PowerShell_profile.ps1" -Force 
		Copy-Item -Path "$env:UserProfile\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -destination "$mydocuments\DTTermTheme\Backups\$date\PSProfile\Microsoft.PowerShell_profile-7.ps1" -Force 
		Copy-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\6.1.0\Themes\Paradox.psm1" -Destination "$mydocuments\DTTermTheme\Backups\$date\PoshTheme\" -Force
		}
		elseif ($overwrite -eq 'N'){
		Write-Output "No problemo, skipping backup..."
		Start-Sleep 5
		}

		else {
		Write-Output "Invalid Input"
		Start-Sleep 3
		Start-Backup
			}
	}
}


function Set-CustomPSTheme {

	[System.Console]::Clear();

Write-Output "Creating Backup..."
Write-Output ""
Write-Output "If this is the first time running the Theme Customiser Option then a backup of your original settings will be created"
Start-Backup


<#
Check if required modules are installed
If not, install them
#>

if (Get-Module -ListAvailable -Name oh-my-posh) {
Write-Output "oh-my-posh Already Installed"
} 

else {
     Install-Module -Name oh-my-posh -Scope CurrentUser -AllowClobber -Confirm:$False -Force  
     }

Write-Output "Copying Files..."

#Copy all the files into the user document folder

$mydocuments = [environment]::getfolderpath("mydocuments")
New-Item -Path  $mydocuments\DTTermTheme -ItemType Directory -Force  | Out-Null
Copy-Item -Path ./* -Destination $mydocuments\DTTermTheme -r -force
Copy-Item -Path "$mydocuments\DTTermTheme\Terminal Profile\settings.json" -Destination "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
Copy-Item -Path "$mydocuments\DTTermTheme\PSProfile\Microsoft.PowerShell_profile.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\" -Force 
Copy-Item -Path "$mydocuments\DTTermTheme\PSProfile\Microsoft.PowerShell_profile-7.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item -Path "$mydocuments\DTTermTheme\PoshTheme\Paradox.psm1" -Destination "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\6.1.0\Themes\Paradox.psm1" -Force

			
<#
Check if the required fonts are installed
If not, then install the required fonts
#>


Write-Output "Installing Fonts"
Write-Output "This will be skipped if they already exist"


$checkfont1 = Test-Path -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\CascadiaCodePL.ttf"
if ($checkfont1 -eq "true") {
  Write-Output "CascadiaCodePL Font Already Installed"
  } 
  else {        
    $FONTS = 0x14
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace($FONTS)
    $objFolder.CopyHere("$mydocuments\DTTermTheme\Fonts\CascadiaCodePL.ttf") 
    Write-Output "CascadiaCodePL Font Now Installed"
       }
Write-Output ""
Write-Output ""
Write-Output ""
$checkfont2 = Test-Path -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\Ubuntu-R.ttf"
if ($checkfont2 -eq "true") {
   Write-Output "Ubuntu-R Font Already Installed"
   } 
   else {        
     $FONTS = 0x14
     $objShell = New-Object -ComObject Shell.Application
     $objFolder = $objShell.Namespace($FONTS)
     $objFolder.CopyHere("$mydocuments\DTTermTheme\Fonts\Ubuntu-R.ttf")  
     Write-Output "Ubuntu-R Font Now Installed"
        }
Write-Output ""
Write-Output ""
Write-Output ""
Write-Output "Customisation Complete Returning To Main Menu"
Start-Sleep 10
}

function Set-Ubuntu20neo {
#Install and enable Neofetch for distro
[System.Console]::Clear();
Write-Host "Enabling Ubuntu-20.04 Neofetch Feature - Enter Sudo Password To Start System Update and Installation" -Foregroundcolor DarkYellow
wsl.exe -d Ubuntu-20.04 sh -c "sudo apt update && sudo apt install neofetch -y && touch ~/.hushlogin" #create hush file to prevent default profile message on this distro
wsl.exe -d Ubuntu-20.04 sh -c "grep -qxF 'neofetch' ~/.profile || echo 'neofetch' >> ~/.profile" #Check if neofetch is already in profile and append if not
Write-Output "."
Write-Host "Neofetch installed and enabled for this distro" -Foregroundcolor DarkYellow
Write-Host "Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
}

function Set-Kalineo {
#Install and enable Neofetch for distro
[System.Console]::Clear();
Write-Host "Enabling Kali Feature - Enter Sudo Password To Start System Update and Installation" -Foregroundcolor Blue
wsl.exe -d kali-linux sh -c "sudo apt update && sudo apt install neofetch -y"
wsl.exe -d kali-linux sh -c "grep -qxF 'neofetch' ~/.profile || echo 'neofetch' >> ~/.profile" #Check if neofetch is already in profile and append if not
Write-Output "."
Write-Host "Neofetch installed and enabled for this distro" -Foregroundcolor Blue
Write-Host "Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
}


function Install-Kalikex {
#
[System.Console]::Clear();
Write-Host "Starting Kali-Kex Install, You Will Need To Enter Sudo Password" -Foregroundcolor Blue
wsl.exe -d kali-linux sh -c "sudo apt update && sudo apt install kali-win-kex -y && sudo apt install dbus-x11 -y"
Write-Host "Kali-Kex Now Installed And Enabled In Windows Terminal -- Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
}

function Set-KaliKexToggle{
#Toggle Kali Kex in Terminal menu
[System.Console]::Clear();
$ProfileInput = Get-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -raw

$truestate = @"
 "guid": "{55ca431a-3a85-5fb3-83dc-11ececc031d2}", 
 "hidden": true, 
"@

$falsestate = @"
 "guid": "{55ca431a-3a85-5fb3-83dc-11ececc031d2}", 
 "hidden": false, 
"@

$findstring = Select-String -path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Pattern "55ca431a-3a85-5fb3-83dc-11ececc031d2" -Context 0,1 | Out-String -Stream | Select-String -Pattern "true"

if ($findstring -Match 'true') {
$ProfileInput -replace $truestate,$falsestate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""
	write-output "Kali-Kex now enabled in Terminal Menu"
	write-output "Returning to Main Menu"
	Start-Sleep 5
								}
else {
$ProfileInput -replace $falsestate,$truestate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""
	write-output "Kali-Kex now disabled in Terminal Menu"
	write-output "Returning to Main Menu"
	Start-Sleep 5
	}
}

function Set-AzureToggle{
#Toggle Azure in terminal menu
[System.Console]::Clear();
$ProfileInput = Get-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -raw

$truestate = @"
 "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}", 
 "hidden": true, 
"@

$falsestate = @"
 "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}", 
 "hidden": false, 
"@

$findstring = Select-String -path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Pattern "b453ae62-4e3d-5e58-b989-0a998ec441b8" -Context 0,1 | Out-String -Stream | Select-String -Pattern "true"

if ($findstring -Match 'true') {
$ProfileInput -replace $truestate,$falsestate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""
	write-output "Azure now enabled in Terminal Menu"
	write-output "Returning to Main Menu"
	Start-Sleep 5
                               }
else {
$ProfileInput -replace $falsestate,$truestate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""
	write-output "Azure now disabled in Terminal Menu"
	write-output "Returning to Main Menu"
	Start-Sleep 5
     }
}

function Set-CommandPromptRetroToggle{
#Toggle the Command Prompt Retro theme
[System.Console]::Clear();
$ProfileInput = Get-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -raw

$disabledstate = @"
 "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}", 
 "name": "Command Prompt",
 "commandline": "cmd.exe", 
 "hidden": false 
"@

$enabledstate = @"
 "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
 "name": "Command Prompt",
 "commandline": "cmd.exe",
 "closeOnExit" : true,
 "colorScheme" : "Retro",
 "cursorColor" : "#FFFFFF",
 "cursorShape": "filledBox",
 "fontSize" : 16,
 "padding" : "5, 5, 5, 5",
 "tabTitle" : "Command Prompt",
 "fontFace": "PxPlus IBM VGA8",
 "experimental.retroTerminalEffect": true,
 "hidden": false,
 "commandline": "cmd.exe" 
"@

$findstring = Select-String -path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Pattern "cmd.exe" -Context 0,2 | Out-String -Stream | Select-String -Pattern "Retro"

if ($findstring -Match "Retro") {
$ProfileInput -replace $enabledstate,$disabledstate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""
	write-output "Command Prompt Retro theme now disabled"
	write-output "Returning to Main Menu"
	Start-Sleep 3
}

else {

$ProfileInput -replace $disabledstate,$enabledstate | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	Write-Output ""	
	write-output "Command Prompt Retro theme now enabled"
	write-output "Returning to Main Menu"
	Start-Sleep 3
}
}

function Show-MainMenu {

	param (
		[string]$Title = "Doubtful Turnip's Mega-Script"
	)
	[System.Console]::Clear();
	Write-Host ""
	$banner
	Write-Host ""
	Write-Host ""
	Write-Host ""
	Write-Host "============ $Title ==========="
	Write-Host ""
	Write-Host "1: Press '1' To install Funky Powershell Customisations."
	Write-Host "2: Press '2' To Enable/Disable Azure in Terminal Menu. (Disabled with Option One)"
	Write-Host "3: Press '3' To Enable/Disable Command Prompt Retro Theme"
	Write-Host "4: Press '4' To Backup PowerShell and Terminal Configs"
	Write-Host ""
        Write-Host "============ WSL Customisations ==========="
	Write-Host ""
	Write-Host "5: Press '5' To install and enable neofetch for Ubuntu-20.04" -Foregroundcolor DarkYellow
	Write-Host "6: Press '6' To install and enable neofetch for Kali-Linux." -Foregroundcolor Blue
	Write-Host "7: Press '7' To install Kali-Kex" -Foregroundcolor Blue
	Write-Host "8: Press '8' To Enable/Disable Kali-Kex in Terminal Menu." -Foregroundcolor Blue
	Write-Host ""
        Write-Host "============================================"
	Write-Host ""
	Write-Host "Q: Press 'Q' to quit" -Foregroundcolor Red -Backgroundcolor White
	Write-Host ""
			}

do 
			{
		Show-MainMenu
		$selection = Read-Host "Please make a selection"
		switch ($selection)
		{
		
		'1' {
		Set-CustomPSTheme
		}

		'2' {
		Set-AzureToggle
		}
		
		'3' {
		Set-CommandPromptRetroToggle
		}
		
		'4' {
		Start-Backup
		}

		'5' {
		Set-Ubuntu20neo
		}

		'6' {
		Set-Kalineo
		}
		
		'7' {
		Install-Kalikex
		}

		'8' {
		Set-KaliKexToggle
		}

		}
			}
until ($selection -eq 'q')
