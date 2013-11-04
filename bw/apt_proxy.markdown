#### How to configuration vm proxy

Go to /etc/apt. Create the file apt.conf if you don't have it there. Write the following lines there.
```bash
Acquire::http::proxy "http://username:password@proxyserver:port/";
Acquire::https::proxy "https://username:password@proxyserver:port/";
Acquire::socks::proxy "socks://username:password@proxyserver:port/";
```
Save it. You are done.

check the [origin source](http://askubuntu.com/questions/77449/how-to-configure-proxy-authentication-to-work-with-ubuntu-software-center)

