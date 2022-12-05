# Search a folder path for files that contain a specific date embedded in the file name and copt files to another folder
$sourcePath  = 'J:\FTP\AcHistory\Upload'
$destination = 'C:\_\2015-04-01'

# if the destination folder does not already exist, create it
if (!(Test-Path -Path $destination -PathType Container)) {
    $null = New-Item -Path $destination -ItemType Directory
}

Get-ChildItem -Path $sourcePath -Filter '*2015-04-01*.csv' -File -Recurse | ForEach-Object {
    $newName = '{0}' -f $_.Name
    $_ | Copy-Item -Destination (Join-Path -Path $destination -ChildPath $newName)
}
