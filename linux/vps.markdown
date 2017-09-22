### setup new user


```ruby
adduser ken
#add user and group

adduser ken sudo
#added ken to sudo list

userdel -r ken
#delete user and group
```

#### During setup ramnode

```ruby
#can not install aptitude
sudo apt-get update
sudo apt-get upgrade

#debconf: unable to initialize frontend: Dialog
apt-get install dialog



```


```
perl: warning: Setting locale failed.
perl: warning: Please check that your locale settings:
LANGUAGE = “en_US.UTF-8″,
LC_ALL = “en_US.UTF-8″,
LANG = “en_US.UTF-8″
```

### add dns 




First, temporarily add a known DNS server to your system.

```ruby
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

```

Then run sudo apt-get update.

If this fixes your temporary resolving messages then either wait for 24 hours to see if your ISP fixes the issue for you (or just contact your ISP) - or you can permanently add a DNS server to your system:


```ruby
echo "nameserver 8.8.8.8" | sudo tee /etc/resolvconf/resolv.conf.d/base > /dev/null
```

8.8.8.8 is Google's own DNS server.





```ruby
sudo locale-gen en_US.UTF-8
```
[reference local ](http://stackoverflow.com/questions/2499794/how-can-i-fix-a-locale-warning-from-perl)

Just add the user to the sudo group:

`sudo adduser <username> sudo`
Group membership is only evaluated upon login, so if the user is already logged in they'll have to log out and in before they can use their new permissions.

This works because /etc/sudoers is pre-configured to grant permissions to all members of this group (You should not have to make any changes to this):

```ruby
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL
```

As long as you have access to a user that is in the same groups as your "original" user, you can delete the old one.

Realistically, there are also other groups your new user should be a member of. If you set the Account type of a user to Administrator in Users Settings, it will be placed in at least all of these groups:

adm sudo lpadmin sambashare
Because your system configuration may vary, I suggest taking a look at the output of groups <username> to see what groups are normally in use.


### how big 

```
du -sh `ls .` 
```

### kill

```
ps ax |grep master | awk '{print $1}' |xargs kill -9  

#查询并显示 -v是不包括， sed是选第二个 awk是打印第几个
ps ax |grep unicorn_rails | grep -v grep | sed -n 2p| awk '{print $1}'

```


### digital ocean swap file

https://www.digitalocean.com/community/articles/how-to-add-swap-on-ubuntu-12-04



```ruby
#add file
sudo dd if=/dev/zero of=/swapfile bs=1024 count=256k

sudo mkswap /swapfile

sudo swapon /swapfile

swapon -s

sudo vim /etc/fstab
#add following line
/swapfile swap swap defaults 0 0


echo 10 | sudo tee /proc/sys/vm/swappiness
echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf

#Swappiness in the file should be set to 10. Skipping this step may cause both poor performance, whereas setting it to 10 will cause swap to act as an emergency buffer, preventing out-of-memory crashes.


```


and also 


```ruby
#edit 

#sudo vim /etc/sysctl.conf
vm.vfs_cache_pressure = 50


```

check [ detail ](https://www.digitalocean.com/community/articles/how-to-add-swap-on-ubuntu-14-04) 

https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-14-04

https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-16-04

add swap for ubuntu 14.04 lts

install sphinx

```
sudo aptitude install sphinxsearch

```

#mysql2 lib

```
sudo aptitude install libmysqlclient-dev
```


