# Install-Module ChocoDeploy -Scope AllUsers
# Install-Module PSIntuneAuth -Scope AllUsers
# Install-Module AzureAd -Scope AllUsers
# Install-Module intunewin32app -Scope AllUsers

Set-Location $PSScriptRoot

Import-Module ..\ChocoDeploy

$chocoApp = 'googlechrome'

$workingFolder = 'C:\tmp\sws-choco-apps'
$tenantName = 'swisssalary.ch'

Get-ChocoInfo -PackageName $chocoApp -OutputPath $workingFolder

# Chocolatey Installer
#New-ChocoClientApp -IntuneWinAppExePath .\IntuneWinAppUtil.exe -Win32AppPath $workingFolder -TenantName $tenantName

# App 
New-ChocoApp -JsonFile "$($workingFolder)\$($chocoApp).json" -IntuneWinAppExePath .\IntuneWinAppUtil.exe -TenantName $tenantName -Verbose -Win32AppPath $workingFolder