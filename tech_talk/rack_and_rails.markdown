## Rack and Rails



### What's Rack

a Ruby Webserver Interface

Rack provides a minimal interface between webservers supporting Ruby and Ruby frameworks.

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
