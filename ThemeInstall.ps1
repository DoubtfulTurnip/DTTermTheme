Write-Output "Installing BuksheePSTheme..."
sleep 5
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Modules"

Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module windows-screenfetch -Scope CurrentUser -Force
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Copying Files..."
New-Item -Path  C:\Programdata\BuksheePSTheme -ItemType Directory -Force  | Out-Null
Copy-Item ./* C:\Programdata\BuksheePSTheme -r -force
Copy-Item -Path "C:\ProgramData\BuksheePSTheme\Terminal Profile\settings.json" -Destination "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
Copy-Item -Path "C:\ProgramData\BuksheePSTheme\PSProfile\Microsoft.PowerShell_profile.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\" -Force
Copy-Item -Path "C:\ProgramData\BuksheePSTheme\PSProfile\Microsoft.PowerShell_profile-7.ps1" -destination "$env:UserProfile\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force
Copy-Item -Path "C:\ProgramData\BuksheePSTheme\PoshTheme\Paradox.psm1" -Destination "$env:UserProfile\Documents\WindowsPowerShell\Modules\oh-my-posh\2.0.496\Themes\Paradox.psm1" -Force
Write-Output "."
Write-Output "."
Write-Output "."
Write-Output "Installing Fonts - If the fonts already exist you will be asked if you want to overwrite - Either option is fine"
$FONTS = 0x14
$Path="c:\programdata\BuksheePSTheme\Fonts\"
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$Fontdir = dir $Path
foreach($File in $Fontdir) {
  $objFolder.CopyHere($File.fullname, 16)
}

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
wsl.exe -d Ubuntu-20.04 sh -c "sudo apt update && sudo apt install neofetch -y && echo neofetch >> ~/.profile"
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
Sleep -Seconds 10

