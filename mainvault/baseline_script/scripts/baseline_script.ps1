function Get-BLWizard {
  
  write-host "Welcome To the BaseLine Script Wizzard!"
  $global:credential = Get-Credential -Message "Please enter your remote access credentials"

  # Import the CSV file
  $computerlistCSV = Read-Host "Please now enter the full path of your CSV file containing target computers"
  $computerList = Import-Csv -Path $computerlistCSV

  Write-Host "Checking wether PSremoting is enabled...."
  # Clear the global psrcomputers array
  $global:psrcomputers = @()

  # Loop over each computer
  foreach ($computer in $computerList) {
      # Try to establish a PSRemoting session
      try {
          $null = Test-WSMan -ComputerName $computer.Name -ErrorAction Stop
          $isPSRemotingEnabled = $true
      }
      # Catch any errors
      catch {
          $isPSRemotingEnabled = $false
      }

      # Add the result to the global psrcomputers array
      $global:psrcomputers += New-Object PSObject -Property @{
          ComputerName = $computer.Name
          PSRemotingEnabled = $isPSRemotingEnabled
      }

      Write-Output "ComputerName: $($psrcomputers.ComputerName), PSRemotingEnabled: $($psrcomputers.PSRemotingEnabled)"
  }
  function Show-Menu
{
     param (
           [string]$Title = 'Choose Your Adventure!'
     )
     Write-Host "Please Choose from the following selections"
     Write-Host "╔══════════════════════════════════════════╗"
     Write-host "║        Lenny moment ( ͡° ͜ʖ ͡° )            ║"
     write-host "╠══════════════════════════════════════════╣"
     Write-Host "║ 1: Get-ConnectionInfo                    ║"
     Write-Host "║ 2: Get-UsersandGroupsInfo                ║"
     Write-Host "║ 3: Get-ProcessInfo                       ║"
     Write-Host "║ 4: Get-ServiceInfo                       ║"
     Write-Host "║ 5: Get-AutoRunsInfo                      ║"
     Write-Host "║ 6: Get-PortInfo                          ║"
     Write-Host "║ 7: Get-HistoricalDevices                 ║"
     Write-Host "║ 8: Get-PluggedInDevices                  ║"
     Write-Host "║ 9: Get-NetworkShares                     ║"
     Write-Host "║ 10: Get-CompInfo                         ║"
     Write-Host "║ 11: Get-FirewallRules (Note: big chonka) ║"
     write-host "║ 12: Run All                              ║"
     write-host "║ 13: Just Don't, you will regret it.      ║"
     Write-Host "║ Q: Quit.                                 ║"
     write-host "╚══════════════════════════════════════════╝"
}

$functions = @{
    1 = 'Get-ConnectionInfo'
    2 = 'Get-UsersandGroupsInfo'
    3 = 'Get-ProcessInfo'
    4 = 'Get-ServiceInfo'
    5 = 'Get-AutoRunsInfo'
    6 = 'Get-PortInfo'
    7 = 'Get-HistoricalDevices'
    8 = 'Get-PluggedInDevices'
    9 = 'Get-NetworkShares'
    10 = 'Get-CompInfo'
    11 = 'Get-FirewallRules'
}

do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-ConnectionInfo -folder $folder
           }
           '2' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-UsersandGroupsInfo -folder $folder
           }
           '3' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-ProcessInfo -folder $folder
           }
           '4' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-ServiceInfo -folder $folder
           }
           '5' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-AutoRunsInfo -folder $folder
           }
           '6' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-PortInfo -folder $folder
           }
           '7' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-HistoricalDevices -folder $folder
           }
           '8' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-PluggedInDevices -folder $folder
           }
           '9' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-NetworkShares -folder $folder
           }
           '10' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-CompInfo -folder $folder
           }
           '11' {
                $folder = Read-Host -Prompt 'Enter output location'
                Get-FirewallRules -folder $folder
           }
           '12' {
                Write-host "Excellent Choice Good Sir/Madam! We recomend you go grab a coffee and wait out by the smoko pit for a while.."
                $folder = Read-Host -Prompt 'Enter default output location'
                foreach ($functionName in $functions.Values) {
                    Invoke-Expression "$functionName -folder $folder"
                }
           }
           '13' {
              write-host "ಠ ╭╮ ಠ"  
              Write-host "You monster...."
              write-host "Why would you hurt lenny like that?"
           }
           'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
}
function Get-ConnectionInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Your command here
          $data = Invoke-Command -ScriptBlock {
              # Your script block here
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
      } | Select-Object -Property IPAddress,InterfaceAlias,AddressFamily,PrefixOrigin,NetworkCategory,InterfaceDescription,MacAddress,ifStatus,LinkSpeed
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to execute the command on $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}

function Get-UsersandGroupsInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Your command here
          $data = Invoke-Command -ScriptBlock {
              # ----> Your script block here <----
              Get-LocalGroup | ForEach-Object { $group = $_; Get-LocalGroupMember -Group $_.Name -ErrorAction SilentlyContinue | Select-Object @{N='GroupName';E={$group.Name}}, Name }
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to execute the command on $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
function Get-ProcessInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the list of all running processes
          $data = Invoke-Command -ScriptBlock {
              Get-WmiObject -Class Win32_Process | ForEach-Object {
                  $userName = $_.GetOwner().User
                  [PSCustomObject]@{
                      ProcessName = $_.Name
                      Id = $_.ProcessId
                      UserName = $userName
                      CommandLine = $_.CommandLine
                  }
              }
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the process information from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
function Get-ServiceInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the list of all running services
          $data = Invoke-Command -ScriptBlock {
              Get-WmiObject -Class Win32_Service | ForEach-Object {
                  $path = $_.PathName -replace '^.+?(?=\\)', '' -replace '^"','' -replace '".*$',''
                  $hash = if (Test-Path $path) { Get-FileHash -Path $path -Algorithm SHA256 | Select-Object -ExpandProperty Hash } else { $null }
                  [PSCustomObject]@{
                      ServiceName = $_.Name
                      Path = $_.PathName
                      Hash = $hash
                  }
              }
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the service information from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
function Get-AutoRunsInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the list of all autorun entries and their hash values
          $data = Invoke-Command -ScriptBlock {
              $keys = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run', 
                      'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
              $results = foreach ($key in $keys) {
                  if (Test-Path $key) {
                      $keyData = Get-ItemProperty -Path $key
                      $keyData.PSObject.Properties | Where-Object { $_.Value -match '^"?(.*\.exe)"?'} | ForEach-Object {
                          $executable = if ($_.Value -match '^"([^"]+)"') { $matches[1] } else { $_.Value }
                          if (Test-Path $executable) {
                              $hash = (Get-FileHash -Path $executable -Algorithm SHA256).Hash
                          } else {
                              $hash = $null
                          }
                          [PSCustomObject]@{
                              Key = $key
                              Name = $_.Name
                              Executable = $executable
                              Hash = $hash
                          }
                      }
                  }
              }
              return $results
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the autorun hash information from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}

function Get-PortInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )
  
  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the open TCP ports
          $data = Invoke-Command -ScriptBlock {
              Get-NetTCPConnection | Where-Object { $_.State -eq 'Established' } | 
              Select-Object -Property LocalAddress, LocalPort, RemoteAddress, RemotePort, State, OwningProcess
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the network information from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}

function Get-HistoricalDevices {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the peripheral devices
          $data = Invoke-Command -ScriptBlock {
              Get-PnpDevice | Select-Object -Property Status, Class, FriendlyName
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the peripheral devices from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}

function Get-PluggedInDevices {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the peripheral devices
          $data = Invoke-Command -ScriptBlock {
              Get-PnpDevice | Where-Object { $_.Present -eq $true } | Select-Object -Property Status, Class, FriendlyName
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the peripheral devices from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}

function Get-NetworkShares {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the network shares
          $data = Invoke-Command -ScriptBlock {
              Get-SmbShare | Where-Object { $_.Name -ne 'IPC$' } | Select-Object -Property Name, Path, Description
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the network shares from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
function Get-CompInfo {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the computer info
          $data = Invoke-Command -ScriptBlock {
              Get-ComputerInfo |
              Select-Object -Property CsName, CsNumberOfProcessors, CsNumberOfLogicalProcessors, OsName, OsVersion, OsBuildNumber, OsLastBootUpTime, OsUptime, BiosSeralNumber, BiosVersion, WindowsFirewallDomainOn, WindowsFirewallPrivateOn, WindowsFirewallPublicOn
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the computer info from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
function Get-FirewallRules {
  param(
      [Parameter(Mandatory=$true)]
      [string] $folder
  )

  $functionName = (Get-Command -Name $MyInvocation.MyCommand).Name

  # Create an empty array to store the results
  $results = @()

  # Create a new folder for the CSV file
  $folderPath = Join-Path -Path $folder -ChildPath $functionName
  if (!(Test-Path -Path $folderPath)) {
      New-Item -ItemType Directory -Path $folderPath | Out-Null
  }

  # Check if PSRemoting is enabled on the computer
  $global:psrcomputers | Where-Object { $_.PSRemotingEnabled -eq $true } | ForEach-Object {
      $computerName = $_.ComputerName
      try {
          # Get the firewall rules
          $data = Invoke-Command -ScriptBlock {
              Get-NetFirewallRule | Where-Object { $_.Enabled -eq 'True' } | ForEach-Object {
                  $rule = $_
                  $security = $rule | Get-NetFirewallSecurityFilter
                  $port = $rule | Get-NetFirewallPortFilter
                  $application = $rule | Get-NetFirewallApplicationFilter
                  New-Object -TypeName PSObject -Property @{
                      Name = $rule.Name
                      DisplayName = $rule.DisplayName
                      Description = $rule.Description
                      Direction = $rule.Direction
                      Action = $rule.Action
                      Protocol = $security.Protocol
                      LocalPort = $port.LocalPort
                      RemotePort = $port.RemotePort
                      Program = $application.Program
                  }
              }
          } -ComputerName $computerName -Credential $global:credential -ErrorAction Stop

          # Add the data to the results array
          $results += $data | Select-Object @{Name='ComputerName'; Expression={$computerName}}, *
      } catch {
          Write-Output "Failed to get the firewall rules from $computerName"
      }
  }

  # Create a CSV file name
  $csvFileName = Join-Path -Path $folderPath -ChildPath "$functionName.csv"

  # Output the results to a CSV file
  $results | Export-Csv -Path $csvFileName -NoTypeInformation
}
