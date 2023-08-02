Function Find-Evil {  
	Param(  
		[Parameter(Mandatory=$true,ValueFromPipeline=$true)]  
		[ValidateLength(8,10)]  
		[string]$computerName)
        Invoke-Command -ScriptBlock { Get-Process } -ComputerName $computerName  
}