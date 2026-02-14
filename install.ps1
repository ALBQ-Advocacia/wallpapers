# ==============================
# Company Branding Deployment
# ==============================

# Define paths
$BrandingFolder = "C:\Company"
$WallpaperSource = "https://raw.githubusercontent.com/ALBQ-Advocacia/wallpapers/refs/heads/main/wallpaper.jpeg"
$LockscreenSource = "https://raw.githubusercontent.com/ALBQ-Advocacia/wallpapers/refs/heads/main/wallpaper.jpeg"

$WallpaperDestination = "$BrandingFolder\wallpaper.jpg"
$LockscreenDestination = "$BrandingFolder\lockscreen.jpg"

# Create folder if not exists
if (!(Test-Path $BrandingFolder)) {
    New-Item -Path $BrandingFolder -ItemType Directory -Force
}

# Download images
Invoke-WebRequest -Uri $WallpaperSource -OutFile $WallpaperDestination
Invoke-WebRequest -Uri $LockscreenSource -OutFile $LockscreenDestination

# ==============================
# Set Desktop Wallpaper
# ==============================

New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" -Force | Out-Null

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "DesktopImageStatus" -Value 1 -Type DWord

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "DesktopImagePath" -Value $WallpaperDestination -Type String

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "DesktopImageUrl" -Value $WallpaperDestination -Type String

# ==============================
# Set Lock Screen Image
# ==============================

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "LockScreenImageStatus" -Value 1 -Type DWord

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "LockScreenImagePath" -Value $LockscreenDestination -Type String

Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP" `
    -Name "LockScreenImageUrl" -Value $LockscreenDestination -Type String

# Force update
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

Write-Output "Branding applied successfully."
