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
