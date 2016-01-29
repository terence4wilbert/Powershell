$USERS = Import-CSV 'C:\Users\twilbert\Documents\CSV\Email Import.csv'
$log = 'C:\Users\twilbert\Documents\CSV\log.txt'
$Date = Get-Date
$oldHeader = "OLD DATA"
$newHeader ="UPDATED DATA"


foreach ($element in $USERS) {
    <#Console#>
	$Names= $element.'name '
    $Number= $element.EmployeeNumber
    $GetUser = get-aduser -Filter{samAccountName -eq $Names} -properties MobilePhone,EmployeeNumber,EmailAddress
    $UpdateInfo = get-aduser -Filter{samAccountName -eq $Names}   | Set-ADuser -mobilePhone $Number 
    $CurrentInfo = get-aduser -Filter{samAccountName -eq $Names} -properties MobilePhone,EmployeeNumber,EmailAddress
  
    if(Get-ADUser -Filter{samAccountName -eq  $Names} ) 
    {
        $Names
    $Number
    Write-Output " "
    $oldHeader
    $GetUser
    $UpdateInfo 
    $newHeader
    $CurrentInfo

    <#LogFile#>
    $Date | Out-File $log -Append
    "User ID: $Names"| Out-File $log -Append
    "Updated Mobile Number: $Number"| Out-File $log -Append
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

