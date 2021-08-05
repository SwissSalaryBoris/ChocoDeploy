# Install-Module ChocoDeploy -Scope AllUsers
# Install-Module PSIntuneAuth -Scope CurrentUser
# Install-Module AzureAd -Scope CurrentUser
# Install-Module intunewin32app -Scope CurrentUser

Set-Location $PSScriptRoot

Import-Module AzureAd
Import-Module ..\ChocoDeploy

$chocoApp = 'pdf24'

$workingFolder = 'D:\BENUTZER\BOST\tmp\sws-choco-apps'
$tenantName = 'swisssalary.ch'

Connect-MSIntuneGraph -TenantName $tenantName -PromptBehavior RefreshSession

Get-ChocoInfo -PackageName $chocoApp -OutputPath $workingFolder

# Chocolatey Installer
#New-ChocoClientApp -IntuneWinAppExePath ..\lib\IntuneWinAppUtil.exe -Win32AppPath $workingFolder -TenantName $tenantName

# App
New-ChocoApp -JsonFile "$($workingFolder)\$($chocoApp).json" -IntuneWinAppExePath ..\lib\IntuneWinAppUtil.exe -TenantName $tenantName -Win32AppPath $workingFolder