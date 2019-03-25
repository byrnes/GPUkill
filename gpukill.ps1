Add-Type -AssemblyName System.Windows.Forms

if (-NOT(Test-Path -Path 'C:\Program Files\NVIDIA Corporation\NVSMI\')) {
    Write-Host "Nvidia-SMI not found"
    exit
}
$pidList = 'C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe'
$tmp = (& $pidList --query-compute-apps=pid --format=csv)
$output += $tmp.split(' ')
Write-Host $output
foreach ($i in $output) {
    if ((-NOT ($i -eq 'pid')) -and (-NOT (Get-Process -Id $i | Select-Object -ExcludeProperty Name) -eq "dwm")) {
        $names += Get-Process -Id $i | Select-Object -ExpandProperty Name
        $names += ", "
    }
}

foreach ($i in $output) {
    if ((-NOT ($i -eq 'pid')) -and (-NOT (Get-Process -Id $i | Select-Object -ExcludeProperty Name) -eq "dwm")) {
        $list += $i
        $list += ", "
    }
}

Write-Host "output: " $list
Write-Host "output length" $output.length

if (-NOT ($output.Length -eq 1)) {

    $oReturn = [System.Windows.Forms.MessageBox]::Show("Do you want to kill the following processes:" + $names, "GPUKill", [System.Windows.Forms.MessageBoxButtons]::OKCancel)	
    switch ($oReturn) {
        "OK" {
            Write-Host "You pressed OK"
            foreach ($i in $output) {
                if (-NOT ($i -eq 'pid')) {
                    Write-Host $i
                    Stop-Process -Id $i -Force
                }
            }
        } 
        "Cancel" {
            Write-Host "You pressed Cancel"
        } 
    }
}
else {
    Write-host "Nothing running on the GPU"
}