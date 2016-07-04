pug .\src\deimos.pug -P -o .\dist
Function Register-Watcher {
    param ($folder)
    $filter = "*.*" #all files
    $watcher = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
        IncludeSubdirectories = $true
        EnableRaisingEvents = $true
    }

    $changeAction = [scriptblock]::Create('
	 	$path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
		Write-Host (pug .\src\deimos.pug -P -o .\dist)
    ')

    Register-ObjectEvent $Watcher "Changed" -Action $changeAction
}
$path = Join-Path $PSScriptRoot .\src\
 Register-Watcher $path

