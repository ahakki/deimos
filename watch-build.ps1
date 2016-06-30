Function Register-Watcher {
    param ($folder)
    $filter = "*.*" #all files
    $watcher = New-Object IO.FileSystemWatcher $folder, $filter -Property @{
        IncludeSubdirectories = $false
        EnableRaisingEvents = $true
    }

    $changeAction = [scriptblock]::Create('
	 	$path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType
        $timeStamp = $Event.TimeGenerated
		node-sass .\src\style.sass -o .\src\includes\style\
		pug .\src\deimos.pug -P -o .\dist
        Write-Host "Change Detected: Building!"
    ')

    Register-ObjectEvent $Watcher "Changed" -Action $changeAction
}

 Register-Watcher "C:\Users\ahakki\Documents\deimos\src"

