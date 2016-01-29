$USERS = Import-CSV 'C:\Users\twilbert\Documents\AD clean up\Phone Data12142015.csv'
$log = 'C:\Users\twilbert\Documents\PhoneExports\log.txt'
$Date = Get-Date
$oldHeader = "OLD DATA"
$newHeader ="UPDATED DATA"



foreach ($element in $USERS) {
    <#Console#>
	$Names= $element.'User ID 1'
    $workPhone = $element.'Directory Number 1'

 

    $GetUser = get-aduser -Filter{samAccountName -eq $Names} -properties OfficePhone |sort-object 
    $UpdateInfo = get-aduser -Filter{samAccountName -eq $Names}   | Set-ADuser -OfficePhone $workPhone  |Sort-Object
    $CurrentInfo = get-aduser -Filter{samAccountName -eq $Names} -properties OfficePhone |Sort-Object
  
  


    if(Get-ADUser -Filter{samAccountName -eq  $Names} ) 
    {
    $Names

    Write-Output " "
    $oldHeader
    $GetUser
    $UpdateInfo 
    $newHeader
    $CurrentInfo

    <#LogFile#>
    $Date | Out-File $log -Append
    "User ID: $Names"| Out-File $log -Append
    "Updated OfficePhone: $workPhone"| Out-File $log -Append
    Write-Output " "| Out-File $log -Append
    $oldHeader| Out-File $log -Append
    $GetUser| Out-File $log -Append
    $newHeader| Out-File $log -Append
    $CurrentInfo| Out-File $log -Append
    <#LogFile#>
      
    }
    else {
         Write-Output "****The User $Names Does Not Exsist****"| Out-File $log -Append
         Write-Output "****The User $Names Does Not Exsist****"
           }
}

