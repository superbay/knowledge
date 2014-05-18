### unicorn start && stop


```bash
unicorn_rails -c config/unicorn.rb -D -E production
ps aux | grep unicorn | awk '{print $2}' | xargs kill -s 9
```




```ruby
# config/unicorn.rb
RAILS_ROOT = File.expand_path("../..", __FILE__)

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 240
preload_app true

listen 8080, :tcp_nopush => false
listen "#{RAILS_ROOT}/tmp/sockets/union.socket"
pid "#{RAILS_ROOT}/tmp/pids/unicorn.pid"
stderr_path "#{RAILS_ROOT}/log/unicorn.err.log"
stdout_path "#{RAILS_ROOT}/log/unicorn.out.log"
```


restart nginx at ubuntu

```ruby
sudo service restart nginx

brew services list

brew services restart redis

```
