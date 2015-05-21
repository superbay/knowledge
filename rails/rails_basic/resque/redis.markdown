How to use Windows Azure redis cache

```ruby
gem 'redis', github: 'RedisLabs/redis-rb', branch: 'ssl'
```

In config/initializers/redis.rb

```ruby
$redis = Redis.new(:host => '[APP_NAME].redis.cache.windows.net', :port => 6380, :db => 10, :password => "[ACCESS_TOKEN]", :use_ssl => true)
```
