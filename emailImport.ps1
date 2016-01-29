# Mobile Phone Number Import Script
#
#
# Specificy path to .csv file mapping account name and mobile phone number.
$data = Import-CSV C:\Users\twilbert\Documents\CSV\cellnumbers.csv
#
# Specify path to log file.
$log = "C:\Scripts\import-mpn.log"
#
# Specify FQDN(s) to search.
$Domains = @(
"domain.com"
"child1.domain.com"
"child2.domain.com"
"child3.domain.com"
)
# Assign Mobile Phone Number to account from .csv
ForEach ($line in $data)
{
$name = $line.Name
$number = $line.Number
$Domains | % {Get-ADUser -Service $_ -Identity $name | Set-ADUser -EmployeeNumber $number | Out-File -FilePath $log -Append}
}