### home page

[home page](https://github.com/resque/resque)


Currently There are two versions of resque according to the official home page

### basic resque (versio 1 stabe)

Just two step

1)  create a rails environment rake task

```ruby
#lib/tasks/resque.rake
require "resque/tasks"

task "resque:setup" => :environment

## for heroku

require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"
```

2)  create a job for perform


```ruby
#app/works/some_job.rb
class SomeJob
  @queue = :high
  
  def self.perform(some_id)
    debugger
  end
end
```

3) Run work

```
rake resque:work QUEUE='*'
```

4) you can try it by rails console

```ruby
Resque.redis
Resque.enqueue SomeJob, some_id

```

5) You can confirm it running well, if you get debugger at rake task or check 
resque-web
```
resque-web
```


