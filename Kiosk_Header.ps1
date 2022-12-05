$outfile = "Data.xxx"
$path = ""
$ErrorActionPreference = "silentlycontinue"
clear
$path = Read-Host "Please enter file path to PowerShell Script"
Set-location -path $path
$Array = Import-csv -Path .\KIOSK-IN-Header.csv | Select-object *,@{Name='Ping_match';Expression="."},@{Name='Lookup_match';Expression="."},@{Name='Kiosk';Expression="."},@{Name='OpsProxy';Expression="."},@{Name='IPName';Expression="."}
$count =1 ; $arraycount = $Array.Count -1
$Array | ForEach-Object { 
    if (test-Connection -ComputerName $_.Adapt_PCName -Count 1 -Quiet )                          {$_.Ping_match = "."}   else  {$_.Ping_match = "X"}     
    try {$_.DistinguishedName = get-ADcomputer $_.Adapt_PCName -Property * | Select DistinguishedName,ManagedBy,Description}   catch {$_.DistinguishedName = "X"}                            




#    try {$_.DistinguishedName = get-ADcomputer $_.Adapt_PCName -Property DistinguishedName | Select DistinguishedName}   catch {$_.DistinguishedName = "X"}                            
#    try {$_.ManagedBY = get-ADcomputer $_.Adapt_PCName -Property ManagedBy | Select ManagedBy}                           catch {$_.ManagedBy = "X"}    
#    try {$_.Description = get-ADcomputer $_.Adapt_PCName -Property Description | Select Description}                     catch {$_.Description_ = "X" }   
#    try {$_.IPName = [System.Net.Dns]::GetHostAddresses($_.Adapt_PCName).IPAddressToString}                              catch {$_.IPName  = "X"}  
#    try {$_.HostName = [system.net.dns]::resolve($_.Adapt_PCName) | Select HostName ; $_.Lookup_match = "."}             catch {$_.HostName  = "X" ;  $_.Lookup_match = "X"}
    clear
    write-host $count "of" $arraycount "   " $_.Adapt_IP "   " $_.IPName "   " $_.Adapt_PCName "   " $_.HostName    
    $count = $count +1    
 } 
clear
$Array | Select 'Ping_match','Lookup_match','Kiosk','OpsProxy','MatchIP','MatchPC','Adapt_DHCP','Adapt_System','Adapt_Facility','Adapt_Account','Adapt_IP','IPName','Adapt_PCName','Hostname','Description','DistinguishedName','ManagedBy'| export-csv -Path .\$Outfile -Delimiter ";" -NoTypeInformation -Force 
write-host "Analysis Completed  "  $arraycount " Computers Evaluated    Import $Outcsv file into Kiosk.xlsm"
$Array.clear()