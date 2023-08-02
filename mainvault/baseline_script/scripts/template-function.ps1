function Template-Function {
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
