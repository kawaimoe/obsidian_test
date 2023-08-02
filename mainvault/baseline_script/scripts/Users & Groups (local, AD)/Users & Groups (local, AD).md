
Get Local users:
```Powershell
Get-CimInstance -ClassName Win32_UserProfile | Select-Object -Property SID,LastUseTime,LocalPath
```

Get logged on users
```Powershell
Get-CimInstance -ClassName Win32_LoggedonUser
```

