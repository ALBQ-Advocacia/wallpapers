# ==============================
# Remove Company Branding
# ==============================
$BrandingFolder = "C:\Company"
$RegPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\PersonalizationCSP"

# Remove registry settings if they exist
if (Test-Path $RegPath) {

    Remove-ItemProperty -Path $RegPath -Name "DesktopImageStatus" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $RegPath -Name "DesktopImagePath" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $RegPath -Name "DesktopImageUrl" -ErrorAction SilentlyContinue

    Remove-ItemProperty -Path $RegPath -Name "LockScreenImageStatus" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $RegPath -Name "LockScreenImagePath" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $RegPath -Name "LockScreenImageUrl" -ErrorAction SilentlyContinue
}

# Remove branding folder
if (Test-Path $BrandingFolder) {
    Remove-Item -Path $BrandingFolder -Recurse -Force
}


# Restart Explorer to refresh wallpaper
Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe

Write-Output "Branding removed successfully."
