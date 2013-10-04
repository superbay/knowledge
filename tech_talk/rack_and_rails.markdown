## Rack and Rails

![screen shot 2013-10-03 at 9 40 29 pm](https://f.cloud.github.com/assets/83296/1266773/0f2cd5ba-2c96-11e3-8309-7ec8bc909d63.png)


### What's Rack

> a Ruby Webserver Interface

> Rack provides a minimal interface between webservers supporting Ruby and Ruby frameworks.

-- Offical Rack Website

### Basic Rack

```ruby
class JSONServer
  def call(env)
    [200, {"Content-Type" => "application/json"}, ['{ "message" : "Hello!" }']]
  end
end

map '/hello.json' do
  run JSONServer.new
end
```


#### Resource

1. http://southdesign.de/blog/rack.html
2. [Official Rack Website](http://rack.github.io/) 
