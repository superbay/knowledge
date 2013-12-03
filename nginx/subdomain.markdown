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
