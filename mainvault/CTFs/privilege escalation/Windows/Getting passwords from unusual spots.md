## Unattended Windows Installations

credentials may be left over after sccm deploys a unattended image to the machine

can be found at:

- C:\\Unattend.xml
- C:\\Windows\\Panther\\Unattend.xml
- C:\\Windows\\Panther\\Unattend\\Unattend.xml
- C:\\Windows\\system32\\sysprep.inf
- C:\\Windows\\system32\\sysprep\\sysprep.xml

Powershell history:

NOTE: must be in cmd.exe:

```shell-session
type %userprofile%\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt
```

## Saved Windows Credentials

`cmdkey /list`

`runas /savecred /user:admin cmd.exe`

## IIS Configuration

Depending on the installed version of IIS, we can find web.config in one of the following locations:

- C:\\inetpub\\wwwroot\\web.config
- C:\\Windows\\Microsoft.NET\\Framework64\\v4.0.30319\\Config\\web.config

can be quickly found with:

```cmd.exe
type C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\web.config | findstr connectionString
```

## Retrieve Credentials from Software: PuTTY

```shell-session
reg query HKEY_CURRENT_USER\Software\SimonTatham\PuTTY\Sessions\ /f "Proxy" /s
```