```
sudo apt install openssl

openssl genrsa -aes256 -out {insert key name}.key 2048

#enter passphrase#

openssl req -new -x509 -key {key name}.key -sha256 -days {expiration days} -out {domain} inc2CA.pem

#enter passphrase, country name, state, city, org-name, OU (optional), email address#

#install fake domain CA as root on all devices (TBC)#
```

Aquire a webserver certificate using OpenSSL

```bash
#aquire a web server certificate using OpenSSL

#generate key#

openssl genrsa -aes256 -out www.fakesite.local.key 2048

#enter passphrase#

#generate certificate signing request based off key above#

openssl req -new www.fakesite.local.key -out www.fakesite.local.csr

#enter details#

#issue certificate#

openssl x509 -req -in www.fakesite.local.csr -CA FakeDomain2CA.pem -CAkey CAprivate.key -CAcreateserial -extfile otherinfo.ext -out www.fakesite.local.crt -day 365 -sha256

#enterdetails#

#output should end with 'crt' extension#

#install ssl module in apache2#

#use a2enmod or enable ssl & port 443 in /etc/apache2/sites-enabled/000-default.conf#
```

![Screenshot 2023-03-02 at 09.06.44.png](../_resources/Screenshot%202023-03-02%20at%2009.06.44.png)

resources needed:

decrypted private key

root cert

steps:

add root cert to firewall then add decrypted private key

next make an internal certificate for website using imported CA creds

export CA.crt from pfsense then import into web browser