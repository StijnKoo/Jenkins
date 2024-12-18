# PowerShell script voor installatie en uitvoering

# 1. Installeer .NET SDK 8
Write-Host "Installing .NET SDK 8..."
$dotnetSdkUrl = "https://download.visualstudio.microsoft.com/download/pr/8e5c41d9-820b-47f9-b463-21659c6d0997/4b3cde9b971c57682d2a987dba32c0bc/dotnet-sdk-8.0.100-win-x64.exe"
$dotnetSdkInstaller = "dotnet-sdk-8.0.100-win-x64.exe"

Invoke-WebRequest -Uri $dotnetSdkUrl -OutFile $dotnetSdkInstaller
Start-Process -FilePath $dotnetSdkInstaller -ArgumentList "/quiet", "/norestart" -Wait
Write-Host ".NET SDK 8 Installed"

# 2. Clone je GitHub repository
Write-Host "Cloning GitHub repository..."
$repoUrl = "https://github.com/StijnKoo/ITM-2.git" # Vervang met je eigen repository URL
$repoPath = "C:\Users\stijn\OneDrive - ROC van Twente\Documenten\Technisch Beheer & Monitoring Jaar 2- Semester-3\Site"  # Pas de gewenste map voor het klonen aan

git clone $repoUrl $repoPath
Write-Host "Repository cloned to $repoPath"

# 3. Navigeer naar de frontend map en voer de EasyDevOps app uit
Write-Host "Navigating to frontend directory and running EasyDevOps app..."
$frontendPath = "$repoPath\MyFrontend"  # Pas aan indien de frontend zich in een andere map bevindt

# Ga naar de frontend map
Set-Location -Path $frontendPath

# Voer de frontend app uit
dotnet run
Write-Host "EasyDevOps app is running..."
