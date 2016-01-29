$USERS = Import-CSV C:\Users\twilbert\Documents\CSV\ADinfo.csv
$log = 'C:\Users\twilbert\Documents\CSV\log.txt'
$Date = Get-Date
$oldHeader = "OLD DATA"
$newHeader ="UPDATED DATA"


if (!(test-path $USERS))
{
    Write-Host "File $USERS not found. Please verify and try again..." -Foreground Red
    exit
}
Else
{
foreach ($element in $USERS) {
    <#Console#>
	$Names= $element.'ADConnector '
    $employeeID= $element.EmployeeID
    $workPhone = $element.'Work Phone'
    $company = $element.Company
    $department = $element.Department
    $departmentTitle = $element.'Department title'
    $job = $element.Job
    $manager = $element.Manager

    $GetUser = get-aduser -Filter{samAccountName -eq $Names} -properties MobilePhone,EmployeeNumber,EmailAddress, EmployeeID, OfficePhone, Company, Department, title, manager |sort-object 
    $UpdateInfo = get-aduser -Filter{samAccountName -eq $Names}   | Set-ADuser -employeeID $employeeID -OfficePhone $workPhone -Company $company -Department $department -title $job -manager $manager |Sort-Object
    $CurrentInfo = get-aduser -Filter{samAccountName -eq $Names} -properties MobilePhone,EmployeeNumber,EmailAddress, EmployeeID, OfficePhone, Company, Department, title, manager |Sort-Object
  
  
    if ($User.manager -eq $null)
   {
    Set-ADUser -Identity $User.manager -Manager $User.mobile
    }


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
    "Updated EmployeeID : $employeeID"| Out-File $log -Append
    "Updated OfficePhone : $workPhone"| Out-File $log -Append
    "Updated Company : $company"| Out-File $log -Append
    "Updated Department : $department"| Out-File $log -Append
    "Updated Job : $job"| Out-File $log -Append
    "Updated Manager : $manager"| Out-File $log -Append
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

}