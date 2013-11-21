### 3 console tips from 37 signals

#### using app

```ruby
app.class
#=> ActionDispatch::Integration::Session
```

#### route path

```ruby
app.project_path(Project.first)
#=> "/projects/130349783-with-attachments"
```

#### trigger a request

```ruby
app.get "/735644780/projects/605816632-bcx.atom" 
#=> 200

app.response.body
#=> "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<feed xml:lang=\"en-US\"  ...
```


### Where does that method come from?

```ruby
Project.instance_method(:trash).source_location
#=> ["/Users/qrush/37s/apps/bcx/app/models/project.rb", 90]

app.method(:get).source_location
=> ["/Users/qrush/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/bundler/gems/rails-7d95b814583b/actionpack/lib/action_dispatch/testing/integration.rb", 32]

```

