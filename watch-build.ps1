# watch a file changes in the current directory,
# execute all tests when a file is changed or renamed

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = '.\src\'
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $false
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName

node-sass .\src\style.sass -o .\src\includes\style\;
pug .\src\deimos.pug -P -o .\dist;
write-host "initial build completed.";
write-host "watching";

while($TRUE){
	$result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed -bor [System.IO.WatcherChangeTypes]::Renamed -bOr [System.IO.WatcherChangeTypes]::Created, 1000);
	if($result.TimedOut){
		continue;
	}
    node-sass .\src\style.sass -o .\src\includes\style\;
    pug .\src\deimos.pug -P -o .\dist;

}