### route

#### Building Constraints

```ruby
class DateFormatConstraint 
  def self.matches?(request)
    request.params[:date] =~ /\A\d{4}-\d\d-\d\d\z/ # YYYY-MM-DD
  end
end

#inroutes.rb
constraints(DateFormatConstraint) do
  get 'since/:date' => :since
end

scope path: '/auctions', controller::auctions do
  get 'new' => :new
  constraints id: /\d+/ do
    get 'edit/:id' => :edit
    post 'pause/:id' => :pause 
  end
end
```

#### scope routes

```ruby
scope controller::auctions do
  get 'auctions/new' => :new
  get 'auctions/edit/:id' => :edit
  post 'auctions/pause/:id' => :pause
end
```

#### path prefix

```ruby
scope path: '/auctions', controller::auctionsdo
  get 'new' => :new
  get 'edit/:id' => :edit
  post 'pause/:id' => :pause
end
```

### Name Prefix

```ruby

scope: auctions, as: 'admin' do
  get 'new' => :new, as: 'new_auction'
end
```

```ruby
link_to"Auctionof#{item.name}",item_path(item.id)
```


#### named routes

```ruby
get 'help' => 'help#index', as: 'help'
```

Argument Sugar

```ruby
get "auction/:auction_id/item/:id" => "items#show", as: "item"  

#you’d be able to call it like
link_to "Auctionof#{item.name}", item_path(auction, item)
```

```ruby
get'items/list/*specs', controller: 'items', action: 'list'

deflist
 specs = params[:specs] # e.g, "base/books/fiction/dickens"
end

#protect records with id under 100
get 'records/:id' => "records#protected", constraints: proc {|req| req.params[:id].to_i < 100 }

#only allow users admin subdomain to do old-schoolrouting
get ':controller/:action/:id' => :show, constraints: { subdomain: 'admin' }

get ':controller/show/:id' => :show, constraints: { :id => /\d+/ }
get ':controller/show/:id' => :show_error
# pay more attention to contrain reguler expression
# it would NOT match "foo32bar"

get ':controller/show/:id' => :show, id: /\d+/
get ':controller/show/:id' => :show_error

get "/hello", to: proc {|env| [200, {}, ["Helloworld"]] }
```



```ruby

ActionDispatch::Routing::Mapper
Example::Application.routes.draw do
end

```

regular

```ruby
get 'products/:id', to: 'products#show'
# equal
get 'products/:id' => 'products#show'
```


```ruby
match 'products/:id' => 'products#show', via:[:get, :post, :patch]
match 'products' => 'products#index', via::any

```

```ruby
get ":id" => "products#show"
match 'products/:id' => 'products#show'
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
