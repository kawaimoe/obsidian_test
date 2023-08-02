function get-rootparentprocess {
    param($process,$allprocesses)

    if(($process.ParentProcessId -in $allprocesses.ProcessId) -and ($processes.ProcessId -ne $process.ParentProcessId)) {
         #If a parent process exists, call the function again, but inspect the parent process ID to see if there is another layer in the hierarchy
         $parentProcess = $allProcesses | Where-Object {$_.ProcessId -eq $process.ParentProcessId} | Select-object -Property Name,ProcessId,ParentProcessId -Unique
         Get-RootParentProcess -process $parentProcess -allProcesses $allProcesses
    }
    Else{#if no parent Process ID exists, we're looking at a root parent process
        #Return the root parent
        $process
    }
    
}

$allprocesses = Get-CimInstance -ClassName Win32_Process | select-object -Property Name,ProcessId,ParentProcessId

$rootparents =  $allprocesses | ForEach-Object { 
    get-rootparentprocess -process $_ -allprocesses $allprocesses 
} | Select-Object -Property name,ProcessId,ParentProcessId -Unique

write-host $rootparents