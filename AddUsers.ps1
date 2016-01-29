# Create Active Directory Accounts and add users to multi groups
# /!\ Groups in csv file MUST be exist in Active Directory
# 
# By CHSA 9/03/2014
# 
Import-Module ActiveDirectory -ErrorAction SilentlyContinue
$Logfile = "AddUser.log"

# set default password
# change pass@word1 to whatever you want the account passwords to be
$defpassword = (ConvertTo-SecureString "pass@word1" -AsPlainText -force)

# Get domain DNS suffix
$dnsroot = '@' + (Get-ADDomain).dnsroot

# Import the file with the users. You can change the filename to reflect your file
$users = Import-Csv .\users.csv
foreach ($user in $users) {
Try
{
$login = $user.SamAccountName
New-ADUser -SamAccountName $login -Name $login -DisplayName ($user.FirstName + " " + $user.LastName) -Surname $user.LastName -UserPrincipalName ($login + $dnsroot) -Description $user.title -Enabled $true -ChangePasswordAtLogon $true -PasswordNeverExpires $false -AccountPassword $defpassword -PassThru 

"Create user $login  ==> Ok" | Add-Content $Logfile
}
catch [Microsoft.ActiveDirectory.Management.ADIdentityAlreadyExistsException]
{
"/!\ ERROR creating user: $login $_ " | Add-Content $Logfile
} 

#####
# Add Users to Groups
#Change number –le 8 group, if you have more than 8 groups per line in your csv file
#####

try
{
for ($i=1; $i –le 8; $i++)
{
$group = $user."grp$i"
add-adgroupmember $group $login
"*** Adduser to group $group OK for user ==> $login " | Add-Content $Logfile
}
	}
catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
            {
               "/!\ Group $group doesn't exist" | Add-Content $Logfile
                
            }
				}