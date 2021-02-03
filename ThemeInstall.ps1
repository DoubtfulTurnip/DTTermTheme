Write-Output "Installing BuksheePSTheme..."
Start-Sleep 5
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Modules"

if (Get-Module -ListAvailable -Name posh-git) {
Write-Output "oh-my-posh Already Installed"
} 
else {
            
      Install-Module -Name oh-my-posh -Scope CurrentUser -AllowClobber -Confirm:$False -Force  
     }

Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Copying Files..."
$mydocuments = [environment]::getfolderpath("mydocuments")
New-Item -Path  $mydocuments\BuksheePSTheme -ItemType Directory -Force  | Out-Null
Copy-Item -Path ./* -Destination $mydocuments\BuksheePSTheme -r -force
Copy-Item -Path "$mydocuments\BuksheePSTheme\Terminal Profile\settings.json" -Destination "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
Copy-Item -Path "$mydocuments\BuksheePSTheme\PSProfile\Microsoft.PowerShell_profile.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\" -Force
Copy-Item -Path "$mydocuments\BuksheePSTheme\PSProfile\Microsoft.PowerShell_profile-7.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item -Path "$mydocuments\BuksheePSTheme\PoshTheme\Paradox.psm1" -Destination "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.496\Themes\Paradox.psm1" -Force
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Fonts"
Write-Output "."
Write-Output "."
Write-Output "."
$checkfont1 = Test-Path -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\CascadiaCodePL.ttf"
if ($checkfont1 -eq "true") {
  Write-Output "CascadiaCodePL Font Already Installed"
  } 
  else {        
    $FONTS = 0x14
    $objShell = New-Object -ComObject Shell.Application
    $objFolder = $objShell.Namespace($FONTS)
    $objFolder.CopyHere("$mydocuments\BuksheePSTheme\Fonts\CascadiaCodePL.ttf")  
       }
Write-Output "."
Write-Output "."
Write-Output "."
$checkfont2 = Test-Path -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\Ubuntu-R.ttf"
if ($checkfont2 -eq "true") {
   Write-Output "Ubuntu-R Font Already Installed"
   } 
   else {        
     $FONTS = 0x14
     $objShell = New-Object -ComObject Shell.Application
     $objFolder = $objShell.Namespace($FONTS)
     $objFolder.CopyHere("$mydocuments\BuksheePSTheme\Fonts\CascadiaCodePL.ttf")  
        }
Write-Output "."
Write-Output "."
Write-Output "."

#Installing updates for WSL Ubuntu 20 and Kali
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Configuring Ubuntu Features"
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Ubuntu Feature - Enter Sudo Password"
wsl.exe -d Ubuntu-20.04 sh -c "sudo apt update && sudo apt install neofetch -y && echo neofetch >> ~/.profile && touch ~/.hushlogin"
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Configuring Kali Features"
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Kali Feature - Enter Sudo Password"
wsl.exe -d kali-linux sh -c "sudo apt update && sudo apt install neofetch -y && echo neofetch >> ~/.profile"
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "."

#Final Message
Write-Output "Theme installation is now complete - Restart your PowerShell instance"
Write-Host "Press any key to continue..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")