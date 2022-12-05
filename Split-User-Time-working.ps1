$set_folder = "C:\_X\~PowerShell\CountOps_AD_Compare"
$Outcsv = $set_folder+"Compare__Split_User_Time_working_csv_out.xxx"
Set-location -path $set_folder

$array.clear() ;clear;   ; $splitter =""
$Array = Import-csv -Path .\gusers-time-working.csv | Select-object *,@{Name='Accounts';Expression="."},@{Name='mailname';Expression="."},@{Name='N1';Expression="."},@{Name='N2';Expression="."},@{Name='N3';Expression="."},@{Name='N3a';Expression="."},@{Name='N3b';Expression="."}
$ErrorActionPreference = "silentlycontinue"
$count =1 ; $arraycount = $Array.Count -1
$Array | ForEach-Object { 
    $splitter =$_.Email1 -split '@' 
        $_.mailname =$splitter[0] -replace '\.'," " 
    $_.Accounts  = get-ADuser $_.mailname | Select GivenName,SurName,UserPrincipalName
    $splitter =$_.Accounts -split '=' 
    $_.N1 =$splitter[1] -replace '; SurName',""                           
    $_.N2 =$splitter[2] -replace '; UserPrincipalName',""               
    $_.N3 =$splitter[3] -replace '}',""                               
    $_.N3a = $_.Email1 -replace '\.'," "
    $_.N3b = $_.N3 -replace '\.'," "
 #   clear
    write-host $_.N1
    write-host $_.N2
    write-host $_.N3
    write-host $count "of" $arraycount "   " $_.N3a  $_.N3b
    $count = $count +1    
    } 
$Array | Select 'Traconid','Facility','Namefirst','N1','Namelast','N2','Email1','N3','mailname','Email2','N3a','N3b','Lastondate','Userid','Accounts'| export-csv -Path $Outcsv -Delimiter ";" -NoTypeInformation -Force 
write-host "Analysis Completed  "  $arraycount " Accounts Evaluated    Import $Outcsv file into Kiosk.xlsm"

#   $_.GivenName = get-ADuser $_.mail2 | Select GivenName
#   $_.Surnamex  = get-ADuser $_.mail2 | Select SurName
#   $_.UserName  = get-ADuser $_.mail2 | Select UserlName
#   write-host $count "of" $arraycount "   " $_.Accounts "    "$_.mail2
#   write-host $count "of" $arraycount
#   $mailname =$_.Email1
#   $_.Accounts = get-ADuser -Filter {UserPrincipalName -eq $mailname} | Select GivenName,SurName,UserPrincipalName
#   $Array | Select 'Namefirst','GivenName','Namelast','SurName','Email1','UserName','Email2'| export-csv -Path $Outcsv -Delimiter ";" -NoTypeInformation -Force 