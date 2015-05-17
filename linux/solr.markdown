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


### remove
```
find /pathtologs/* -mtime +5 -exec rm {} \;
```

I went with the second option, because our developers have coded for dates in the files names. So it needs to stay that way. The -mtime +5 sets find to only look for files who are older then 5 days.



If you specifically want to delete this is a quick way to do it. If you need to some other command you can always replace the ecex rm {} \ ; with some thing else.

http://stackoverflow.com/questions/8962477/logrotate-files-with-date-in-the-file-name



###logging.properties

 To achieve this, in the logging.properties, add: 

```
.handlers = 1catalina.java.util.logging.FileHandler 
.level=FINE 
 
1catalina.java.util.logging.FileHandler.level = FINE 
1catalina.java.util.logging.FileHandler.pattern = ${catalina.base}/logs/${catalina.appserver.instance}.%g.log 
1catalina.java.util.logging.FileHandler.limit = 2000000 
1catalina.java.util.logging.FileHandler.count = 5 
1catalina.java.util.logging.FileHandler.formatter = java.util.logging.SimpleFormatter

```
