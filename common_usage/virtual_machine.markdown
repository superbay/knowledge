### virtual machine

#### forword port

```

Host IP: 127.0.0.1
Host Port: 2222
Guest IP: 10.0.2.15
Guest Port: 22

```
Then enable ssh in the guest, and I'm able to connect from the host using:

```
ssh -p 2222 root@127.0.0.1
```

I haven't tried it because I don't have a 2nd computer, but I think ssh -p 2222 root@192.168.21.121 would also work.


### ssh enable

```
sudo apt-get install ssh
```

Type the following command:
$ sudo /etc/init.d/ssh start

OR
$ sudo service ssh start


### virtual box proxy

Ok, extend this a bit:
Proxy support for the CLI
Add the following lines to the file /etc/environment

```
export http_proxy="http://username:password@host:port/"
```

This will also apply to apt at the CLI. Some applications may pick this up, too. If it doesn't work for you, add the line to /etc/bash.bashrc and /etc/profile, too.


### Generate ssh Key

```ruby

ssh-keygen -t rsa -C "your_email@example.com"

```


