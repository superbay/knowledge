### route

```ruby
#protect records with id under 100
get'records/:id'=>"records#protected",
constraints: proc {|req| req.params[:id].to_i < 100 }



#only allow users admin subdomain to do old-schoolrouting
get':controller/:action/:id'=>:show,constraints:{subdomain:'admin'}
get':controller/show/:id'=>:show,constraints:{:id=>/\d+/}
get':controller/show/:id'=>:show_error
# pay more attention to contrain reguler expression
# it would NOT match "foo32bar"

get':controller/show/:id'=>:show,id:/\d+/
get':controller/show/:id'=>:show_error

get"/hello",to:proc{|env|[200,{},["Helloworld"]]}
```



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

```ruby
def show
  @product = Product.find(params[:id]) respond_to do |format|
      format.html
      format.json { render json: @product.to_json }
      format.any
  end 
end
```
