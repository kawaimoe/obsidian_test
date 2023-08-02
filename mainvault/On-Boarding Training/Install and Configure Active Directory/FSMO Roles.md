Two commands that can list all domain controllers:

```
$DomainName = (Get-ADDomain).DNSRoot
$AllDCs = (Get-ADForest).GlobalCatalogs
```

FSMO maintenance prompt command:

```dos
ntdsutil: roles
```