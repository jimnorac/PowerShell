<#
Master-Restore.ps1 
Pass desired Server to be restored from the command line in SKY6 Restore (by Server)Shortcut
Find last saved Restore and Archive File for each site on SKY6 G:\FTP\FieldSites\xxx\Restore
Clean previous data from SKY6 D:\Restore\CountOps\Data_xxx then unzip data by bsire under CountOps folder
Store Report of Files Restored on SKY6 D:\Restore\Archive_Log_SKYx____YYYY-MM-DD--HH_mm_ss.txt
#>

$SKYName = "SKY8"
#param($SKYName)                                  # Load the SKYName to Restore on the Command Line
$zArray = Import-csv C:\Restore\SKYNames.csv      # Load SKYName to get SiteName and SKYName

$D1 = 'D:\Archives\FTP\FieldSites\'
$A1 = 'G:\FTP\FieldSites\'                        # Archive Path start
$A2 = '\Restore\'                                 # Archive Path middle
$Archive_File =""
$Archive_File1 = '???_Restore?.7z'                # Last Archived         ???_Restore  
$Archive_File2 = '???_CountOps_Archive_?????.7z'  # Last Archived         ???_CountOps_Archive_?????
$Archive_File1N = "name no extension"
$Archive_File2N = "date"

$Archive_File1D = "date"
$Archive_File2D = "date"

$Archive_Path =  "G:\FTP\FieldSites\xxx\Restore"  # Archive Path          G:\FTP\FieldSites\xxx\Restore
$Archive_Filex = "SKY6 path and file"             # Archive path + File   G:\FTP\FieldSites\xxx\Restore\file

$R1 = 'Z:\Program Files\CountOps\'                # Restore Path end
$R2 = 'Data_'

$Year = get-Date -Format yyyy
$Year_x = $Year -1
$Y_1 = $Year-1
$Y_2 = $Year-2
$Y_3 = $Year-3
$Y_4 = $Year-4
$Y_5 = $Year-5
$Y_6 = $Year-6
$Y_7 = $Year-7
$Y_8 = $Year-8
$Y_9 = $Year-9
$Y_10 = $Year-10
$Y_11 = $Year-11
$Y_12 = $Year-12

set-location -path c:\
Get-ChildItem $R1 -recurse | Remove-Item -Recurse -Force
remove-item -Force -Recurse -Path $R1

$Started = (Get-Date)        # store start time for report

$log = "c:\Restore\log\Archive_Log_"+$SKYName+"____"+$(get-date -f yyyy-MM-dd--HH_mm_ss)+".txt"
cls  

$line = ""
Set-Content -Path $log -Value $line -PassThru
$line = $SKYName+" Archive Restore Initiated ..........> "+$started+"                          |"+$Y_1 
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | |"+$Y_2
Add-Content -Path $log -Value $line -PassThru
$line= "SKY6 Archive Data Location ..............> "+$A1+"xxx"+$A2+"               | | |"+$Y_3 
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | |"+$Y_4
Add-Content -Path $log -Value $line -PassThru
$line= "SKY6 OLD Archive Data Location ..........> "+$D1+"xxx"+$A2+"      | | | | |"+$Y_5 
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | |"+$Y_6
Add-Content -Path $log -Value $line -PassThru
$line= "SKY6 Restore Data Location ..............> "+$R1+"xxx\                     | | | | | | |"+$Y_7 
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | | | |"+$Y_8
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | | | | |"+$Y_9
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | | | | | |"+$Y_10
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | | | | | | |"+$Y_11
Add-Content -Path $log -Value $line -PassThrU
$line = "                                                                                        | | | | | | | | | | | |"+$Y_12
Add-Content -Path $log -Value $line -PassThru
$line = "                                                                                        | | | | | | | | | | | | |"
Add-Content -Path $log -Value $line -PassThru
 
$zArray | ForEach-Object{                         # For Loop to Find matches to SKYName in csv file
    If($_.SKYName -like $SKYName)                 # SKYName match start 
  {   
  $Y_1 = ""
  $Y_2 = ""
  $Y_3 = ""
  $Y_4 = ""
  $Y_5 = ""
  $Y_6 = ""
  $Y_7 = ""
  $Y_8 = ""
  $Y_9 = ""
  $Y_10 = ""
  $Y_11 = ""
  $Y_12 = ""
     
  $Restore_Path = $R1+$R2+$_.SiteName             # Identify where to Resore Files
  
  If(!(test-path $Restore_Path)){New-Item -ItemType Directory -Force -Path $Restore_Path > ""}
  set-location -path $Restore_Path
  $Archive_Path = $A1+$_.SiteName+$A2              # Identify the Archive Data Location 
  
  $Search = "???_Restore?.7z"                      # Prepare to search for last written Restore File
  $Archive_File1 = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1 
  
  $Search = "???_CountOps_Archive_?????.7z"        # Prepare to search for last written Archive file 
  $Archive_File2 = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1

  If($Archive_Path -ne $null){                     # If site folder is missing jump over unzip function

    $Archive_Filex = $Archive_Path+$Archive_File1
    $Archive_File1N = (Get-Item $Archive_Filex).BaseName
    $Archive_File1D = (Get-Item $Archive_Filex).LastWriteTime  
      If($Archive_Filex -ne $null){
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Restore file
      }
        
    $Archive_Filex = $Archive_Path+$Archive_File2
    $Archive_File2N = (Get-Item $Archive_Filex).BaseName
    $Archive_File2D = (Get-Item $Archive_Filex).LastWriteTime
      If($Archive_Filex -ne $null){
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the Archive file
      }
    
    $Year_x = $Year -1
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If($Archive_Filex -ne $null){
      $Y_1 = "X "
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }   
    
    $Year_x = $Year -2
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_2 = "X "
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -3
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_3 = "X "    
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -4
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_4 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -5
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_5 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -6
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_6 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -7
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_7 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -8
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_8 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -9
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_9 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -10
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_10 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -11
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_11 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -12
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_12 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }


    $Archive_Path = $D1+$_.SiteName+$A2              # Identify the Archive Data Location  

    $Year_x = $Year -3
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_3 = "X "    
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -4
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_4 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -5
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_5 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -6
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_6 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -7
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_7 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -8
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_8 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -9
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_9 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -10
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_10 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -11
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_11 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -12
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_12 = "X "        
      G:\zip\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
        
   
      
    }
  If($Archive_File1 -eq $null) {$Archive_File1 ="Missing        "}   # If Restore file is missing say Missing in report
  If($Archive_File2 -eq $null) {$Archive_File2 ="Missing"}           # If Archive file is missing say Missing in report
      
  $line = $_.SiteName+'  '+$Archive_File1N+" "+$Archive_File1D+" | "+$Archive_File2N+" "+$Archive_File2D+"  "+$Y_1+$Y_2+$Y_3+$Y_4+$Y_5+$Y_6+$Y_7+$Y_8+$Y_9+$Y_10+$Y_11+$Y_12
  Add-Content -Path $log -Value $line -PassThru
  } 
}

$ended = (Get-Date)                                # Determine how long the Archive Recovery Process took
$difference = New-TimeSpan -Start $started -End $ended

$line = "___________________________________________________________________________________________________________________"
Add-Content -Path $log -Value $line -PassThru
$line= ""
Add-Content -Path $log -Value $line -PassThru
$line = $SKYName+" Archive Restore Completed .........> "+$ended
Add-Content -Path $log -Value $line 
     
write-host "Restore completed              "$ended  
write-host "Restore initiated              "$started  
write-host "                                         ________"
write-host "Archive/Restore Process Time ..........."$difference
write-host ""
write-host ""
write-host "Copy the SKY6 Folder > "$R1" to the New or Need to be Restored Server" 
write-host ""
write-host ""
pause