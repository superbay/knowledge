### upload file 

```bash
curl --noproxy 127.0.0.1 -w %{http_code} -T etc_review40.xml http://127.0.0.1:3000/k4/etc_review40.xml
```

### curl proxy

```bash
#.curlrc
proxy = http://proxy.bloomberg.com:80
insecure
```


While you curl, you can 

```bash
unset http_proxy
```

or 

```bash
curl --noproxy

```
