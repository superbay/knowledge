### how to test engine routes


after rspec 2.14

```ruby
describe "Auths page routing" do
  routes { Utilizer::Engine.routes }
  # ...
end
```


similar appoarch


```ruby
config.before(:each, type: :routing) { @routes = Utilizer::Engine.routes }
#or

config.before(:each, type: :routing) do
  @routes = Utilizer::Engine.routes
  assertion_instance.instance_variable_set(:@routes, Utilizer::Engine.routes)
end
```


one another


```ruby
module MyEngine
  describe ExampleController do
    routes { MyEngine::Engine.routes }
  end
end
Add it to all routing specs:

# spec/spec_helper.rb
config.include Module.new {
  def self.included(base)
    base.routes { Reportr::Engine.routes }
  end 
}, type: :routing
```

