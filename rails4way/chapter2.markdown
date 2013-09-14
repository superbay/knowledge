### route

```ruby

ActionDispatch::Routing::Mapper
Example::Application.routes.draw do
end

```

regular

```ruby
get'products/:id',to:'products#show'
# equal
get'products/:id'=>'products#show'
```
