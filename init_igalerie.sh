#!/bin/bash

set -e
set -x
/usr/sbin/mysqld & mysql_pid=$!
until mysqladmin ping  &>/dev/null;do
    echo -n ".";sleep 0.2
done

/bin/bash -c "source /etc/apache2/envvars && exec /usr/sbin/apache2"


mysql -e "CREATE DATABASE igalerie;"

curl 'http://localhost:80/igalerie/install/?q=step/1' -H 'Host: localhost:80' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Referer: http://localhost:80/igalerie/install/' -H 'Cookie: igal_prefs=a%3A3%3A%7Bs%3A8%3A%22anticsrf%22%3Bs%3A40%3A%2258cbd6ae5336362e8ef0102cb91a90fedfa0a62f%22%3Bs%3A15%3A%22anticsrf_expire%22%3Bi%3A1445760476%3Bs%3A4%3A%22lang%22%3Bs%3A5%3A%22fr_FR%22%3B%7D; igal_session=a%3A1%3A%7Bs%3A5%3A%22token%22%3Bs%3A40%3A%22fe5dab0a0c00d41da83e196c1dbbc7fc2976018d%22%3B%7D; igal_install=a%3A2%3A%7Bs%3A4%3A%22test%22%3Bs%3A9%3A%22123456789%22%3Bs%3A3%3A%22key%22%3Bs%3A32%3A%223600b594453916040f64a328bdccdae9%22%3B%7D' -H 'Connection: keep-alive'


curl 'http://localhost:80/igalerie/install/?q=step/2' -H 'Host: localhost:80' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Referer: http://localhost:80/igalerie/install/?q=step/2' -H 'Cookie: igal_prefs=a%3A3%3A%7Bs%3A8%3A%22anticsrf%22%3Bs%3A40%3A%2258cbd6ae5336362e8ef0102cb91a90fedfa0a62f%22%3Bs%3A15%3A%22anticsrf_expire%22%3Bi%3A1445760476%3Bs%3A4%3A%22lang%22%3Bs%3A5%3A%22fr_FR%22%3B%7D; igal_session=a%3A1%3A%7Bs%3A5%3A%22token%22%3Bs%3A40%3A%22fe5dab0a0c00d41da83e196c1dbbc7fc2976018d%22%3B%7D; igal_install=a%3A2%3A%7Bs%3A4%3A%22test%22%3Bs%3A9%3A%22123456789%22%3Bs%3A3%3A%22key%22%3Bs%3A32%3A%223600b594453916040f64a328bdccdae9%22%3B%7D' -H 'Connection: keep-alive' --data 'server=localhost&user=root&password=&database=igalerie&prefix=igal2_'


curl 'http://localhost:80/igalerie/install/?q=step/3' -H 'Host: localhost:80' -H 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:41.0) Gecko/20100101 Firefox/41.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3' --compressed -H 'Referer: http://localhost:80/igalerie/install/?q=step/3' -H 'Cookie: igal_prefs=a%3A3%3A%7Bs%3A8%3A%22anticsrf%22%3Bs%3A40%3A%2258cbd6ae5336362e8ef0102cb91a90fedfa0a62f%22%3Bs%3A15%3A%22anticsrf_expire%22%3Bi%3A1445760476%3Bs%3A4%3A%22lang%22%3Bs%3A5%3A%22fr_FR%22%3B%7D; igal_session=a%3A1%3A%7Bs%3A5%3A%22token%22%3Bs%3A40%3A%22fe5dab0a0c00d41da83e196c1dbbc7fc2976018d%22%3B%7D; igal_install=a%3A2%3A%7Bs%3A4%3A%22test%22%3Bs%3A9%3A%22123456789%22%3Bs%3A3%3A%22key%22%3Bs%3A32%3A%22d2105e61a39bc5b4c4edfffff006c1f3%22%3B%7D' -H 'Connection: keep-alive' --data 'login=admin&password=123456&password_confirm=123456&email=toto%40tutu.com&title=Ma+galerie&url=http%3A%2F%2Flocalhost%3A80%2Figalerie%2Findex.php&lang_default=fr_FR&tz_default=Europe%2FParis'

mysqladmin shutdown
wait $mysql_pid
