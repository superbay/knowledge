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

