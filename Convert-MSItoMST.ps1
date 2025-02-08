# Convert-MSItoMST.ps1
param($msiPath, $mstPath)
& "C:\Program Files\InstEd\InstEd.exe" "$msiPath" /Transform "$mstPath" /New
