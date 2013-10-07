## Controller

#### Rack

```ruby
class HelloWorld
  def call(env)
   [200, {"Content-Type" => "text/plain"}, ["Hello world!"]]
  end
end
```

#### MiddleWare

```ruby
#application.rb
module Example
  class Application < Rails::Application
    ...
    # Rack::ShowStatus catches all empty responses the app it wraps and 
    # replaces them with a site explaining the error. 
    config.middleware.use Rack::ShowStatus
  end 
end

```