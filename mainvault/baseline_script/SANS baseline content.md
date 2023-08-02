### Interface IP information
```Powershell
Get-NetIPAddress | 
ForEach-Object {
      $_ | Add-Member -MemberType ScriptProperty -Name NetworkCategory -Value {
            Get-NetConnectionProfile -InterfaceAlias $_.InterfaceAlias | Select-Object -ExpandProperty NetworkCategory
      } -PassThru |
      Add-Member -MemberType ScriptProperty -Name InterfaceDescription -Value { 
        Get-NetAdapter -InterfaceAlias $_.InterfaceAlias | Select-Object -ExpandProperty InterfaceDescription 
      } -PassThru |
       Add-Member -MemberType ScriptProperty -Name MacAddress -Value { 
        Get-NetAdapter -InterfaceAlias $_.InterfaceAlias | Select-Object -ExpandProperty MacAddress 
      } -PassThru |
      Add-Member -MemberType ScriptProperty -Name ifstatus -Value { 
        Get-NetAdapter -InterfaceAlias $_.InterfaceAlias | Select-Object -ExpandProperty Status 
      } -PassThru |
      Add-Member -MemberType ScriptProperty -Name LinkSpeed -Value { 
        Get-NetAdapter -InterfaceAlias $_.InterfaceAlias | Select-Object -ExpandProperty LinkSpeed 
      } -PassThru
} | 
Select-Object -Property IPAddress,InterfaceAlias,AddressFamily,PrefixOrigin,NetworkCategory,InterfaceDescription,MacAddress,ifStatus,LinkSpeed


```
### Get default routes (staticly configured interfaces)
```Powershell
Get-NetRoute | 
	Where-Object 
		{$_.DestinationPrefix -eq "0.0.0.0/0"}
```
### Get non-stale arp entries for ipv4 traffic
```Powershell
Get-NetNeighbor -AddressFamily IPv4 -State Reachable
```
### One-liner to ensure nexthop is real gateway and not result of arp posoning
```Powershell
Get-NetNeighbor -State Reachable -IPAddress (Get-NetRoute | Where-Object {$_.DestinationPrefix -eq "0.0.0.0/0"} | Select-Object -ExpandProperty NextHop)
```
### Get listening and established connections:
`Get-NetTCPConnection -state Listen`
`Get-NetTCPConnection -state established`
### Get logged on users:
`Get-CimInstance -ClassName Win32_LoggedonUser
`
### Get users with local profile
```Powershell
Get-CimInstance -ClassName Win32_UserProfile | Select-Object -Property SID,LastUseTime,LocalPath
```
### Is Virtualization-Based Security Enabled?
```Powershell
Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard
```
If the resulting VirtualizationBasedSecurityStatus property is 0, VBS is not enabled. 1 indicates that it is enabled, but not running. 2 indicates that it is enabled and it is running.
### Is Credential Guard Enabled?
```Powershell
Get-ComputerInfo | Select-Object -Property "DeviceGuard*"
```
The resulting property named DeviceGuardSecurityServicesConfigured and DeviceGuardSecurityServicesRunning will show 'CredentialGuard' in the resulting output if this feature is enabled. This simpler output makes it easy for an analyst to interpret during an initial triage scenario.
### Local security policy
`secedit.exe /export /cfg C:\temp\secpolicy.cfg`
### Check for plugged in USB's
`Get-CimInstance -ClassName Win32_DiskDrive | Where-Object {$_.model -eq "USB"}`
### Get file hash of every file downloaded from the internet (zone id 3)
```Powershell
Get-ChildItem C:\Users\student\Downloads | 
ForEach-Object { 
    Get-Item -Path $_.FullName -Stream * | 
    Where-Object { $_.Stream -ne ':$DATA'} | 
    Where-Object { Get-Content $_.FileName -Stream "Zone.Identifier" | 
    Select-String "ZoneId=3" -ErrorAction SilentlyContinue}
    } | 
    Select-Object -Property FileName | 
    ForEach-Object {Get-FileHash -Path $_.FileName}

```
### Child and parent process list
```Powershell
Param(	[Parameter(Mandatory=$true,ValueFromPipeline=$true)]  
		[ValidateLength(8,20)]  
		[string]$computerName)

Invoke-Command -ComputerName $computerName -scriptblock {
    Function Get-RootParentProcess {
        Param($process,$allProcesses)

        #Check to see if a process exists for the Parent Process ID 
        if(($process.ParentProcessID -in $allProcesses.ProcessId) -and ($process.ProcessId -ne $process.ParentProcessId)){
            #If a parent process exists, call the function again, but inspect the parent process ID to see if there is another layer in the hierarchy
            $parentProcess = $allProcesses | Where-Object {$_.ProcessId -eq $process.ParentProcessId} | Select-object -Property Name,ProcessId,ParentProcessId -Unique
            Get-RootParentProcess -process $parentProcess -allProcesses $allProcesses
        }
        else{ #if no parent Process ID exists, we're looking at a root parent process
            #Return the root parent
            $process
        }
    }
    function get-childprocess {
        param($process,$allprocesses,$depth)
        $retTab = "  "*$depth
        $children = $allProcesses | Where-Object {($_.ParentProcessId -eq $process.ProcessId) -and ($_.ProcessId -ne $process.ProcessId)} | Select-Object -Property Name,ProcessId,ParentProcessId -Unique
        $children | ForEach-Object {
            $newDepth = $depth + 1
            $retTab + "- $($_.Name) ($($_.ProcessId))"
            Get-ChildProcess -process $_ -allProcesses $allProcesses -depth $newDepth
        }

    }
    $allProcesses = Get-CimInstance -ClassName Win32_Process | Select-Object -Property Name,ProcessId,ParentProcessId

    $rootParents = $allProcesses | ForEach-Object {
        Get-RootParentProcess -process $_ -allProcesses $allProcesses
    } | Select-object -Property Name,ProcessId,ParentProcessId -Unique

    $rootParents | ForEach-Object { 
        Write-Output "- $($_.name) ($($_.Processid))"
        get-childprocess -process $_ -allprocesses $allProcesses -depth 1
    }
}
```
### Get concise list of executed process (make an xml object)
```Powershell
$myevents = Get-WinEvent -FilterHashtable @{logname="<logname>";id=<id_number>}

$myevents | ForEach-Object {[xml]$e=$_.ToXml();$e.Event.EventData.Data[<processname_nuber>].'#text'} | Group-Object -NoElement | Sort-Object -Property count -Descending | fl
```
