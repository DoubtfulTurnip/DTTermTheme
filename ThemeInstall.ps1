<#
Title:  DoubtfulTurnip's Mega-Script
Author: DoubfulTurnip
#>

$banner = @"



"@

function Set-CustomPSTheme {


#$mydocumentsbackup = [environment]::getfolderpath("mydocuments")
#New-Item -Path  $mydocumentsbackup\DTTermTheme\Backups -ItemType Directory -Force  | Out-Null
#Copy-Item -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Destination "$mydocuments\DTTermTheme\Backups\Terminal Profile\settings.json" -Force
#Copy-Item -Path "$mydocuments\DTTermTheme\PSProfile\Microsoft.PowerShell_profile.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\" -Force
#Copy-Item -Path "$mydocuments\DTTermTheme\PSProfile\Microsoft.PowerShell_profile-7.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force
#Copy-Item -Path "$mydocuments\DTTermTheme\PoshTheme\Paradox.psm1" -Destination "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.496\Themes\Paradox.psm1" -Force

<#
Check if required modules are installed
If not install them
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
Copy-Item -Path "$mydocuments\DTTermTheme\PoshTheme\Paradox.psm1" -Destination "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.496\Themes\Paradox.psm1" -Force

			
<#
Check if the required fonts are installed
If not then install the required fonts
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
Show-MainMenu
}

function Set-Ubuntu20neo {
#Install and enable Neofetch for distro

Write-Host "Enabling Ubuntu-20.04 Neofetch Feature - Enter Sudo Password To Start System Update and Installation" -Foregroundcolor DarkYellow
wsl.exe -d Ubuntu-20.04 sh -c "sudo apt update && sudo apt install neofetch -y && touch ~/.hushlogin" #create hush file to prevent default profile message on this distro
wsl.exe -d Ubuntu-20.04 sh -c "grep -qxF 'neofetch' ~/.profile || echo 'neofetch' >> ~/.profile" #Check if neofetch is already in profile and append if not
Write-Output "."
Write-Host "Neofetch installed and enabled for this distro" -Foregroundcolor DarkYellow
Write-Host "Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
Show-MainMenu
}

function Set-Kalineo {
#Install and enable Neofetch for distro

Write-Host "Enabling Kali Feature - Enter Sudo Password To Start System Update and Installation" -Foregroundcolor DarkBlue
wsl.exe -d kali-linux sh -c "sudo apt update && sudo apt install neofetch -y"
wsl.exe -d kali-linux sh -c "grep -qxF 'neofetch' ~/.profile || echo 'neofetch' >> ~/.profile" #Check if neofetch is already in profile and append if not
Write-Output "."
Write-Host "Neofetch installed and enabled for this distro" -Foregroundcolor DarkBlue
Write-Host "Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
Show-MainMenu
}


function Install-Kalikex {
#
Write-Host "Starting Kali-Kex Install, You Will Need To Enter Sudo Password" -Foregroundcolor DarkBlue
wsl.exe -d kali-linux sh -c "sudo apt update && sudo apt install kali-win-kex -y"
Set-KalikexEnable
Write-Host "Kali-Kex Now Installed And Enabled In Windows Terminal -- Returning to Main Menu" -Foregroundcolor Red
Start-Sleep 5
Show-MainMenu
}

function Set-KaliKexEnable{
#Make Kali-Kex menu enabled for Windows Terminal


$Input = Get-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -raw

$find = @"
 "guid": "{55ca431a-3a85-5fb3-83dc-11ececc031d2}", 
 "hidden": true, 
"@

$replace = @"
 "guid": "{55ca431a-3a85-5fb3-83dc-11ececc031d2}", 
 "hidden": false, 
"@

$Input -replace $find,$replace | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}


function Set-AzureEnable{
#Make Azure menu enabled for Windows Terminal

$Input = Get-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -raw

$find = @"
 "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}", 
 "hidden": true, 
"@

$replace = @"
 "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}", 
 "hidden": false, 
"@

$Input -replace $find,$replace | Set-Content "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}


function Show-MainMenu {

	param (
		[string]$Title = "Doubtful Turnip's Mega-Script"
	)
	Clear-Host
	Write-Host ""
	Write-Host ""
	Write-Host ""
	Write-Host ""
	Write-Host "============ $Title ==========="
	Write-Host ""
	Write-Host "1: Press '1' To install Funky Powershell Customisations."
	Write-Host "2: Press '2' To Re-enable Azure in Terminal (after Option 1)."
	Write-Host ""
        Write-Host "============ WSL Customisations ==========="
	Write-Host ""
	Write-Host "3: Press '3' To install and enable neofetch to Ubuntu-20.04" -Foregroundcolor DarkYellow
	Write-Host "4: Press '4' To install and enable neofetch to Kali-Linux." -Foregroundcolor DarkBlue
	Write-Host "5: Press '5' To install Kali-Kex EXPERIMENTAL" -Foregroundcolor DarkBlue
	Write-Host ""
        Write-Host "============================================"
	Write-Host ""
	Write-Host "Q: Press 'Q' to quit" -Foregroundcolor Red
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
		Set-AzureEnable
		}

		'3' {
		Set-Ubuntu20neo
		}


		'4' {
		Set-Kalineo
		}
		
		'5' {
		Install-Kalikex
		}

		}
			}
until ($selection -eq 'q')