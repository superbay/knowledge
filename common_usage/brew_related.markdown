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


 To have launchd start redis at login:
 
  `ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents`
  
 Then to load redis now:
 
  `launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist`
  
 Or, if you don't want/need launchctl, you can just run:
 
    `redis-server /usr/local/etc/redis.conf`
    
    
    

### list service

```
$ brew services list
redis      started      442 /Users/gabe/Library/LaunchAgents/homebrew.mxcl.redis.plist
postgresql started      443 /Users/gabe/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
mongodb    started      444 /Users/gabe/Library/LaunchAgents/homebrew.mxcl.mongodb.plist
memcached  started      445 /Users/gabe/Library/LaunchAgents/homebrew.mxcl.memcached.plist
mysql      started    87538 /Users/gabe/Library/LaunchAgents/homebrew.mxcl.mysql.plist
```
  
    


