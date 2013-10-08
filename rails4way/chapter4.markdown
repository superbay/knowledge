## View

```ruby
render inline: "%span.foo#{@foo.name}", type: "haml"
render text: 'Submission accepted',content_type: 'text/plain'
render json: @projects, include: :tasks
render json: @record, callback: 'update Records Display'
render nothing: true, status: 401
```

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