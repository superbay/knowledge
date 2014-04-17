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
```

2)  create a job for perform


```ruby
#app/works/some_job.rb
class SomeJob
  @queue = :high
  
  def self.perform(some_id)
  end
end
```
