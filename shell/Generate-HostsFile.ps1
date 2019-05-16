$HostFile = 'C:\Windows\System32\drivers\etc\hosts'

# Create a backup copy of the Hosts file
$dateFormat = (Get-Date).ToString('dd-MM-yyyy hh-mm-ss')
$FileCopy = $HostFile + '.' + $dateFormat  + '.copy'
Copy-Item $HostFile -Destination $FileCopy

$Hosts = @(
  [PSCustomObject]@{
    IPAddress = '10.10.17.12'
    HostName  = 'chefserver.local'
  }
)

# Get the contents of the Hosts file
$File = Get-Content $HostFile

foreach ($HostFileEntry in $Hosts)
{
  Write-Host "Checking existing HOST file entries for $($HostFileEntry.HostName)..."

  #Set a Flag
  $EntryExists = $false

  if ($File -contains "$($HostFileEntry.IPAddress) `t $($HostFileEntry.HostName)")
  {
      Write-Host "Host File Entry for $($HostFileEntry.HostName) is already exists."
      $EntryExists = $true
  }

  #Add Entry to Host File
  if (!$EntryExists)
  {
      Write-host "Adding Host File Entry for $($HostFileEntry.HostName)"
      Add-content -path $HostFile -value "$($HostFileEntry.IPAddress) `t $($HostFileEntry.HostName)"
  }
}
