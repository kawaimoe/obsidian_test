  
### Puppet reset (authentication problems)
 - Computer: Bs-dc01
 - Command: `Puppet agent -t —debug` *this restarts puppet*
 - Config location: `c:\programdata\puppetlabs\puppet\etc\ssl\certificaterequests\*`
	 - delete this and restart puppet
