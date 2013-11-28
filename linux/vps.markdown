### setup new user


```ruby
adduser ken
#add user and group

adduser ken sudo
#added ken to sudo list

userdel -r ken
#delete user and group
```



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
