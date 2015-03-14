### NGINX Redirect http to https and non-www to ww


```
server{
  listen 443 ssl;
  server_name www.mydomain.com;
  root /www/mydomain.com/;

  ssl    on;
  ssl_certificate /ssl/domain.crt;
  ssl_certificate /ssl/domain.key;
  .
  . 
  .
}

server{
  listen 80;
  server_name www.mydomain.com mydomain.com;
  return 301 https://www.$server_name$request_uri;
}

server{
  listen 443;
  server_name mydomain.com;
  return 301 https://www.$server_name$request_uri;
}
```

redirect 

```

server {
  listen 80 443;
  server_name mydomain.com;
  # add ssl settings
  return 301 https://www.mydomain.com$request_uri;
}

```



`sudo service nginx reload`


reference: http://serverfault.com/questions/67316/in-nginx-how-can-i-rewrite-all-http-requests-to-https-while-maintaining-sub-dom

### how to set up two rails app under nginx


1. change your ip setting

  no special setting. just A redirect to root 

2. nginx setting

  [sample](./nginx.conf)



### all subdomain redirect


```ruby

if ( $host ~* (\b(?!www\b)\w+)\.\w+\.\w+ ) {
    set $subdomain /$1;
}
location / {
    root /home/wangyan/public_html$subdomain;
    index index.html index.php;
}

```

all should be in server


[another example](http://stackoverflow.com/questions/16087607/how-to-handle-subdomain-in-rails-with-unicorn-and-nginx)
