#### Lock obtain timed out 

```
SEVERE: org.apache.lucene.store.LockObtainFailedException: Lock obtain timed out: NativeFSLock@/home/solr/solr3/biomina/solr/original/data/index/write.lock
```

```xml

<indexConfig>
    <!-- maxFieldLength specifies max number of *tokens* indexed per 
field. Default: 10000 -->
    <!-- <maxFieldLength>10000</maxFieldLength>  -->
    <!-- Maximum time to wait for a write lock (ms) for an IndexWriter. 
Default: 1000 -->
    <writeLockTimeout>300000</writeLockTimeout>
```


Modified the /usr/share/tomcat7/bin/setenv.sh file as the following (giving it about 4 GB memory):

```
export JAVA_OPTS="$JAVA_OPTS -Xmx4000m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/mnt/data/tomcat_dump
```


### tomcat daily log rotation

If you would like to setup Tomcat logrotation you can do the following:

```
# vi /etc/logrotate.d/qm-tomcat6
```

This will create the logriotate file, that you will have to set up as follows:

```sh
/usr/local/queuemetrics/tomcat/logs/*.log {
  notifempty
  copytruncate
  daily
  rotate 10
  compress
  missingok
}


/usr/local/queuemetrics/tomcat/logs/catalina.out {
  notifempty
  copytruncate
  dateext
  daily
  rotate 10
  compress
  missingok
}
```
If you want to, you can make it take care of cleaning out temp files as well (or just do it from cron as you would normally)

```sh
/usr/local/queuemetrics/tomcat/logs/catalina.out {
  notifempty
  copytruncate
  dateext
  daily
  rotate 10
  compress
  missingok
  postrotate
    /bin/nice /usr/bin/find /usr/local/queuemetrics/tomcat/temp -type f -mtime +10 -exec /bin/rm {} \; > /dev/null
  endscript
}
```

```
/var/log/rsync/dummy {
        daily
        rotate 0
        create
        ifempty
        lastaction
                /usr/bin/find /var/log/rsync/ -mtime +7 -delete
                /usr/bin/find /var/log/rsync/ -mtime +1 -exec gzip -q {} \;
        endscript
}
```


another version

```
#/etc/logrotate.d/confluence
compress
/u/app/confluence/confluence-data/logs/atlassian-confluence.log {
    # rotate weekly
    weekly
    # keep up to 4 logs
    rotate 4
    # do not rotate empty log
    notifempty
    # make new blank log
    create
    # run this once before rotating any logs (if if logs need rotating)
    firstaction
      /u/app/confluence/confluence-current/bin/shutdown.sh
      sleep 30
    endscript
    # run this once after rotating any logs (if if logs needed rotating)
    lastaction
      /u/app/confluence/confluence-current/bin/startup.sh
    endscript
}
```

### remove
```
find /pathtologs/* -mtime +5 -exec rm {} \;
find tomcat/logs/ -mtime +7 -print0 | xargs -r -0 rm -rf
```

I went with the second option, because our developers have coded for dates in the files names. So it needs to stay that way. The -mtime +5 sets find to only look for files who are older then 5 days.



If you specifically want to delete this is a quick way to do it. If you need to some other command you can always replace the ecex rm {} \ ; with some thing else.

http://stackoverflow.com/questions/8962477/logrotate-files-with-date-in-the-file-name

```
find -name "*.tif" -size -160k -delete
```

To verify that the correct files are found run the command without -delete first.

Note the - at -160k. Just 160k means exactly 160 kilobytes. -160k means smaller than 160 kilobytes. +160k means larger than 160 kilobytes.

The find command available in GNU/Linux shells is a versatile tool for finding files matching the given conditions in a folder and performing a specific action on the files found. The following command will find all files greater than 1M size in your current folder and ask you if you would like to delete the file

```
find . -size +1M -exec rm -i {} \;
```

The following command will find all tar.gz files greater than 1M size and ask you whether you wish to delete them.

```
find . -size +1M -name "*.tar.gz" -exec rm -i {} \;
```

The following command will find all tar.gz files greater than 1M size and less than 20M size and ask you whether you wish to delete them.

```
find . -size +1M -name -size -20M "*.tar.gz" -exec rm -i {} \;
```

Find is an extremely powerful tool. To know more check out man find and read through the full set of offerings.

###logging.properties

 To achieve this, in the logging.properties, add: 

```
#/etc/tomcat6/logging.properties
.handlers = 1catalina.java.util.logging.FileHandler 
.level=FINE 
 
1catalina.java.util.logging.FileHandler.level = FINE 
1catalina.java.util.logging.FileHandler.pattern = ${catalina.base}/logs/${catalina.appserver.instance}.%g.log 
1catalina.java.util.logging.FileHandler.limit = 2000000 
1catalina.java.util.logging.FileHandler.count = 5 
1catalina.java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter

```

http://www.vineetmanohar.com/2010/03/howto-rotate-tomcat-catalina-out/
