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


```ruby
match'products/:id'=>'products#show',via:[:get, :post, :patch]
match'products'=>'products#index',via::any

```


```ruby
get":id"=>"products#show"
match'products/:id'=>'products#show'
```
