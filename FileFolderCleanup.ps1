#### THIS SCRIPT WILL CLEANUP OLD FILES AND EMPTY DIRECTORIES SPECIFIED


#HOW MANY DAYS OLD SHOULD A FILE BE BEFORE DELETED? KEEP IN QUOTES.
$Days = "1"
#WHAT TARGET FOLDERS WOULD YOU LIKE TO SEARCH IN FOR FILES AND EMPTY FOLDERS TO BE DELETED? KEEP EACH PATH IN QUOTES AND SEPARATE WITH COMMA LIKE "PATH1","PATH2"
$TargetFolders = "C:\Windows\Temp"
#WHAT FILE EXTENSIONS WOULD YOU LIKE TO SEARCH FOR TO BE DELETED? KEEP IN QUOTES AND SEPARATE WITH COMMA LIKE "*.LOG","*.TMP"
$Extensions = "*.tmp"

#DO NOT EDIT BELOW THIS LINE#

#set remaining variables
$Now = Get-Date 
$LastWrite = $Now.AddDays(-$Days)
$Files = Get-Childitem $TargetFolders -Include $Extensions -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}
$Directories = Get-ChildItem $TargetFolders -Recurse -Directory | Where { (Get-ChildItem -Path $_.FullName -Recurse -File -EA SilentlyContinue | Measure-Object).Count -eq 0 }

#perform old file cleanup
foreach ($File in $Files) 
 {
 if ($File -ne $NULL)
 {
 write-host "Deleting file $File" -ForegroundColor "White"
 Remove-Item $File.FullName | out-null
 }
 else
 {
 Write-Host "No recent files to delete!" -foregroundcolor "Green"
 }
 }
 
#perform empty directory cleanup
 foreach ($Directory in $Directories) 
 {
 if ($Directory -ne $NULL)
 {
 write-host "Deleting empty folder" $Directory.FullName -ForegroundColor "White"
 Remove-Item $Directory.FullName | out-null
 }
 else
 {
 Write-Host "No recent files to delete!" -foregroundcolor "Green"
 }
 }
 