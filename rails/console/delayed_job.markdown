How to run DelayedJob under console


```ruby
Delayed::Worker.new.run(Delayed::Job.last) 

Delayed::Job.find(x).invoke_job

```


Restarting delayed_job
======================

The following syntax will restart delayed jobs:

    RAILS_ENV=production script/delayed_job restart

To restart multiple delayed_job workers:

    RAILS_ENV=production script/delayed_job -n2 restart

**Rails 4:** *replace script/delayed_job with bin/delayed_job*
