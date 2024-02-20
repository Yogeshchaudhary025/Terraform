$LoginName="adminuser"
$LoginPassword="Password@123"
$DatabaseName="appdb"
$ServerName="database-vm"
$DBQuery="CREATE DATABASE appdb"


Invoke-SqlCmd -ServerInstance $ServerName -U $LoginName -p $LoginPassword -Query $DBQuery


$LoginName="adminuser"
$LoginPassword="Password@123"
$ServerName="database-vm"
$DatabaseName="appdb"
$ScriptFile="https://${storage-account-name}.blob.core.windows.net/${container-name}/01.sql"
$Destination="D:\01.sql"


Invoke-WebRequest -Uri $ScriptFile -OutFile $Destination
Invoke-SqlCmd -ServerInstance $ServerName -InputFile $Destination -Database $DatabaseName -Username $LoginName -Password $LoginPassword


