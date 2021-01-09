### change permission recursive


```
$ chmod -R 755 /var/www/html
```


Using the find Command #
In general, the files and directories should not have the same permissions. Most files do not require the execute permission, whereas you must set execute permissions on the directories in order to change into them.

The most common scenario is to recursively change the website file’s permissions to 644 and directory’s permissions to 755.

Using the numeric method:
```
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;
```
Using the symbolic method:
```
find /var/www/html -type d -exec chmod u=rwx,go=rx {} \;
find /var/www/html -type f -exec chmod u=rw,go=r {} \;
```
The find command searches for files or directories under /var/www/html and passes each found file or directory to the chmod command to set the permissions.

When using find with -exec, the chmod command is run for each found entry. Use the xargs command to speed up the operation by passing multiple entries at once:
```
find /var/www/html -type d -print0 | xargs -0 chmod 755 
find /var/www/html -type f -print0 | xargs -0 chmod 644
```

### how to install mac ox 10.10 in virtual box

http://bbs.feng.com/read-htm-tid-8474315.html
