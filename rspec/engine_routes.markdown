### how to test engine routes


popular solution:

more related:

```ruby
# spec_helper.rb
RSpec.configure do |config|
  config.include MyEngine::Engine.routes.url_helpers
end
```


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


[reference](http://stackoverflow.com/questions/11587463/all-routing-examples-fail-for-a-rails-3-2-engine-with-rspec-2-10)



```ruby
describe "test controller routing" do
  routes { Testy::Engine.routes }
  # ...
end

# similar
before(:each) { @routes = Testy::Engine.routes }
```


more related:

```ruby
# spec_helper.rb
RSpec.configure do |config|
  config.include MyEngine::Engine.routes.url_helpers
end
```

```ruby
#spec/spec_helper.rb
RSpec.configure do |config|
 # other code
 config.before(:each) { @routes = MyEngine::Engine.routes }
end
```

[more reference](http://stackoverflow.com/questions/7691594/how-to-test-routes-in-a-rails-3-1-mountable-engine)
