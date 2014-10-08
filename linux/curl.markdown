### Restful API and call

```bash
curl -X POST --data "param1=value1&param2=value2" http://example.com/resource.cgi

```


so far the best way to trigger post call to api. or jason call


http://www.hurl.it/


### curl as ftp 


```bash
curl --user 'ftp_user:ftp_password' --disable-epsv --proxytunnel -x 'yourproxy.com:port'
-T 'your.localfile' 'ftp://remote.ftp.org:port/path' -v
```

#### regular ftp

```bash

$ ftp -n <<EOF
open ftp.example.com
user user secret
put my-local-file.txt
EOF

```

http://stackoverflow.com/questions/9165594/curl-pycurl-ftp-over-http-proxy

### upload file 

```bash
curl --noproxy 127.0.0.1 -w %{http_code} -T etc_review40.xml http://127.0.0.1:3000/k4/etc_review40.xml
```

### curl proxy

```bash
#.curlrc
proxy = http://proxy.hideyourass.com:80
insecure
```


While you curl, you can 

```bash
unset http_proxy
```

or 

```bash
curl --noproxy 127.0.0.1

```


```bash
export PATH=$PATH:/local/usr/ruby192/bin
```

### track session

```
sudo tcpdump -i lo0 -A

curl http://todo.dev/
curl http://todo.dev/ -H 'Cookie:'

```


