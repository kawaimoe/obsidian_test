
**Get-netipAddress extended**
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
