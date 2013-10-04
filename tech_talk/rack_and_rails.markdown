## Rack and Rails

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
2. 
