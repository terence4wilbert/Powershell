$CSV = Import-CSV ' '
$log = ' '

foreach ($element in $CSV) {
    <#Console#>
	$alias = $element.alias
    $mailBox = Get-Mailbox -resultsize unlimited -Identity $alias | disable-Mailbox -Identity alias 

    if(Get-Mailbox -Identity $_.alias -eq $alias) {
        $mailBox | Out-File $log -Append
    }
    else {
         Write-Output "****The User $alias Does Not Exsist****"| Out-File $log -Append
    }
}

