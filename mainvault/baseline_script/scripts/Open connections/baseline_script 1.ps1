function get-openconnections {
  param(
    [Parameter(Mandatory=$true,ValueFromPipeline=$true, Position=0)]  
		[ValidateLength(8,10)]
		[string]$computerName,
    
    [Parameter(Mandatory=$true, Position=1)]
    [System.Management.Automation.PSCredential]$Credential, 

    [Parameter(Mandatory=$true, Position=2)]
    [string]$path
  )
  invoke-command -ScriptBlock {Get-NetIPAddress | 
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
    Select-Object -Property IPAddress,InterfaceAlias,AddressFamily,PrefixOrigin,NetworkCategory,InterfaceDescription,MacAddress,ifStatus,LinkSpeed | ConvertTo-Csv | out-file -FilePath ("$path" + "openconnections.csv")
  } -noprofile -ComputerName $computerName -Credential $credential
  
  #tests if the output was correct
  $testresult = test-path -path ("$path" + "openconnections.csv")
  
  if ($testresult) {write-host ("Operation was successfull, file located at " + "$path" + "openconnections.csv")
  }
  elseif ($testresult -ne $true) {
  write-host "Operation was not succesfull, either script is fucked or you entered something wrong"
  }
}



  
