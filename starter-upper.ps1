# $ErrorActionPreference = "Stop"

$startupFileJson = ( Get-Content ./startup.json ).replace("\", "\\") | ConvertFrom-Json
$startupList = $startupFileJson.startupItems

Write-Host "Starter-upper! Here we go..."

foreach($item in $startupList) {
    $exe = $item.exe
    $args = $item.args
    $delay = $item.delay
    $workingDir = $item.workingDir
    $runAsAdmin = $item.runAsAdmin
    
    Write-Host "Waiting $delay seconds to start '$exe'"
    Start-Sleep -s $delay
    
    if ($args -eq $NULL -or !$args) {
        Start-Process -FilePath $exe -WorkingDirectory $workingDir -WindowStyle Minimized
        
        if ($runAsAdmin) {
            Start-Process -FilePath $exe -WorkingDirectory $workingDir -WindowStyle Minimized -Verb RunAs
        }
    }
    else {
        Start-Process -FilePath $exe -WorkingDirectory $workingDir -ArgumentList $args -WindowStyle Minimized
        
        if ($runAsAdmin) {
            Start-Process -FilePath $exe -WorkingDirectory $workingDir -ArgumentList $args -WindowStyle Minimized -Verb RunAs
        }
    }
}

Write-Host "Done!"

Start-Sleep 5