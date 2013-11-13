### restart service

```bash
brew services list
brew services restart redis
```

old way of redis

```bash
sudo redis-server /usr/local/etc/redis.conf
```

brew instruction


>  To have launchd start redis at login:
>      ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
>  Then to load redis now:
>      launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
>  Or, if you don't want/need launchctl, you can just run:
>      redis-server /usr/local/etc/redis.conf
    
    


