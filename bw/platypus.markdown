## What I am using here

zookeeper phbricator teamcity jira newrelic A/B jerkin capistrano


### failover

Since sandy, We have disaster recovery. Here is the layer need to recoer 

 1. app tier 
 2. web tier
 3. api tier
 4. syndicator 
 5. redis
 6. scheduler (resque pool and resque scheduler)
 7. mysql 
 8. elastic search which failed
 9. image_sync
 10. wordpress
 11. memcache (dalli with 6 instance)
 12. zookeeper
 13. haproxy


Phabricator for code review
