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

6) for heroku deployment

```ruby
#config/initializers/resque.rb

ENV["REDISTOGO_URL"] ||= "redis://username:password@host:1234/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

## special for rails 4 or later
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => ENV['REDISTOGO_URL'])
```


### redis basic

```ruby

# config/initializers/redis.rb 
 
$redis = Redis::Namespace.new("site_point", :redis => Redis.new)

$redis.set("test_key", "Hello World!")

$redis.get("test_key")

# app/helpers/category_helper.rb
 
module CategoryHelper
  def fetch_categories
    categories =  $redis.get("categories")
    if categories.nil?
      categories = Category.all.to_json
      $redis.set("categories", categories)
    end
    @categories = JSON.load categories
  end
end


# app/helpers/category_helper.rb
 
module CategoryHelper
  def fetch_categories
    categories =  $redis.get("categories")
    if categories.nil?
      categories = Category.all.to_json
      $redis.set("categories", categories)
      # Expire the cache, every 3 hours
      $redis.expire("categories",3.hour.to_i)
    end
    @categories = JSON.load categories
  end
end
```

