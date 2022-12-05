# Restore.ps1 
# Windows shortcut file for each Server
# Find last saved Restore and Archive File for each site on SKY6                                               
# Store Report of Files Restored in the Restore Log folder   format Archive_Log_SKYx____YYYY-MM-DD--HH_mm_ss.txt


Clear-Host
$SKYName = $args[0]     # Pass SKYName from Shortcut   Example below script is on D:\restore passing SKY2
                        # C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe D:\Restore\Restore.ps1 SKY2
                        #
                        # Start with path to powershell                                  folder with ps1 file       and identify SKY
                        # C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe      D:\Restore\Restore.ps1     SKY2

                # mapping   SKY6    JC     testing with USB Drive
$D_A = 'J:'     # A Archive    E     J     D
$D_L = 'D:'     # L Log        D     K     D
$D_R = 'D:'     # R Restore    Y     Y     D

$unzip = $D_L+"\Restore\7za.exe" 
$rpath = $D_L+"\Restore\SkyNames.csv" 

# $zArray = Import-csv D:\Restore\SkyNames.csv     # Load SKYName.csv map of SiteName to SKYName                  
$zArray = Import-csv $rpath                        # Load SKYName.csv map of SiteName to SKYName                  
$A1 = $D_A+"\FTP\FieldSites\"                        # Archive Path start                                         
$A2 = '\Restore\'                                    # Archive Path middle
$Archive_File1 = '???_Restore?.7z'                   # Last Archived         ???_Restore  
$Archive_File2 = '???_CountOps_Archive_?????.7z'     # Last Archived         ???_CountOps_Archive_?????
$Archive_File1N = "name no extension"
$Archive_File2N = "date"

$Archive_File1D = "date"
$Archive_File2D = "date"

$Archive_Path =  $D_A+"\FTP\FieldSites\xxx\Restore"  # Archive Path          
$Archive_Filex = "SKY6 path and file"                # Archive path + File   

$R1 = $D_R+"\Program Files\CountOps\"                # Restore Path end
$R2 = 'Data_'                                        # hold Data_ and then will add site name stored in Data_xxx format


$Year = get-Date -Format yyyy
#$year_x =""
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

#set-location -path $D_A
#Get-ChildItem $R1 -recurse | Remove-Item -Recurse -Force
#remove-item -Force -Recurse -Path $R1

$Started = (Get-Date)        # store start time for report

$log = $D_L+"\Restore\log\Archive_Log_"+$SKYName+"____"+$(get-date -f yyyy-MM-dd--HH_mm_ss)+".txt"
#Clear-Host  

$line = ""
Set-Content -Path $log -Value $line -PassThru 
$line = $Year+" --- Recover Archived Restore and History Data"
Add-Content -Path $log -Value $line -PassThru
$line = ""
Add-Content -Path $log -Value $line -PassThru 
$line = ""
Add-Content -Path $log -Value $line -PassThru 


$line = $SKYName+" Archive Restore Initiated ..........> "+$started
Add-Content -Path $log -Value $line -PassThru
$line = ""
Add-Content -Path $log -Value $line -PassThru
$line= "SKY6 Archive Data Location ..............> "+$A1+"xxx"+$A2
Add-Content -Path $log -Value $line -PassThru
$line = "" 
Add-Content -Path $log -Value $line -PassThru
$line= $SKYName+" Restore Data Location ..............> "+$R1+"xxx\"
Add-Content -Path $log -Value $line -PassThru
$line = ""
Add-Content -Path $log -Value $line -PassThru
$line = ""
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
  $Archive_Path = $A1+$_.SiteName+$A2             # Identify the Archive Data Location 
  
  $Search = "???_Restore?.7z"                     # Prepare to search for last written Restore File
  $Archive_File1 = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1 
  
  $Search = "???_CountOps_Archive_?????.7z"       # Prepare to search for last written Archive file 
  $Archive_File2 = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1

  If($Archive_Path -ne $null){                    # If site folder is missing jump over unzip function

    $Archive_Filex = $Archive_Path+$Archive_File1
    $Archive_File1N = (Get-Item $Archive_Filex).BaseName
    $Archive_File1D = (Get-Item $Archive_Filex).LastWriteTime  
      If($Archive_Filex -ne $null){
      & $unzip e -aoa $Archive_Filex > ""      # Unzip the LastWritten Restore file
      }
        
    $Archive_Filex = $Archive_Path+$Archive_File2
    $Archive_File2N = (Get-Item $Archive_Filex).BaseName
    $Archive_File2D = (Get-Item $Archive_Filex).LastWriteTime
      If($Archive_Filex -ne $null){
      & $unzip e -aoa $Archive_Filex > ""      # Unzip the Archive file
#     D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Restore file
      }
    
    <#
    $Year_x = $Year -1
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If($Archive_Filex -ne $null){
      $Y_1 = "X "
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }   
    
    $Year_x = $Year -2
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_2 = "X "
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -3
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_3 = "X "    
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -4
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_4 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -5
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_5 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -6
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_6 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -7
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_7 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -8
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_8 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -9
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_9 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -10
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_10 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -11
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_11 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -12
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_12 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }


    $Archive_Path = $D1+$_.SiteName+$A2              # Identify the Archive Data Location  

    $Year_x = $Year -3
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_3 = "X "    
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    
    $Year_x = $Year -4
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_4 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -5
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_5 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -6
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_6 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -7
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_7 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -8
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_8 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -9
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_9 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -10
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_10 = "X "        
      c:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -11
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_11 = "X "        
      D:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }

    $Year_x = $Year -12
    $Search = "???_CountOps_Archive_"+$Year_x+"?.7z" # Prepare to search for last written Archive file 
    $Archive_File = Get-ChildItem -path ${Archive_Path} -Filter $Search -ErrorAction SilentlyContinue | sort-object lastwritetime | Select-Object -last 1
    $Archive_Filex = $Archive_Path+$Archive_File
      If ($Archive_File -ne $null){
      $Y_12 = "X "        
      c:\Restore\7za.exe e -aoa $Archive_Filex > ""      # Unzip the LastWritten Current Year -2 History 
      }
    #>    
      
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
