#### Formated Named Routes

```ruby
link_to "XML version of this auction", auction_path(@auction, :xml)

#This will generate the following HTML: 
<a href="/auctions/1.xml"> XML version of this auction</a>
```


### respond_to & respond_with 

```ruby
def index
  @auctions = Auction.all 
  respond_to do |format|
    format.html
    format.xml { render :xml => @auctions } 
  end
end
```

And also could be define it together

```ruby
class AuctionsController < ApplicationController
  respond_to :html, :xml, :json
  def index
    @auctions = Auction.all
    respond_with(@auctions)
  end
end
```


```ruby
resources :projects, path_names: { new: 'nuevo', edit: 'cambiar' }


GET /projects/nuevo(.:format)  projects#new 
GET /projects/:id/cambiar(.:format)  projects#edit
```


```ruby
resources :auctions do
  resources :bids do
    member do
      get :retract
      post :retract
    end
  end
end

resources :auctions do
  resources :bids do
    match :retract, via: [:get, :post], on: :member
    match :terminate, via: [:get, :post], on: :collection
  end
end


```





### extra memerb

```ruby
resources :auctions do 
  resources :bids do
    member do
      get :retract
    end
  end
end

link_to "Retract", retract_bid_path(auction, bid)
link_to "Retract", retract_bid_path(auction, bid), method::post
```



### concern in routes

```ruby
resources: auctions do
  resources :bids
  resources :comments
  resources :image_attachments, only: :index
end

resources :bids do
  resources :comments
end
```

Could be write as

```ruby
concern :commentable do
  resources :comments
end

concern :image_attachable do
  resources :image_attachments, only: :index
end
```

```ruby
resources :auctions, concerns: [:commentable, :image_attachable] do
  resources :bids
end
resources :bids, concerns: :commentable
```



### shallow

```ruby

resources :auctions, shallow: true do
  resources :bids do
    resources :comments
  end
end

#same as 

resources :auctions do
  shallow do
    resources :bids do
      resources :comments
    end
  end
end

```

![screen shot 2013-10-01 at 10 01 22 pm](https://f.cloud.github.com/assets/83296/1250784/a88fbe52-2b06-11e3-860b-0797acf026e0.png)


### restful

```ruby
/auctions/3/bids/5
resources:auctions do
 resources :bids
end

link_to "Seeallbids", auction_bids_path(auction)
link_to "Deletethisbid", auction_bid_path(auction, bid), method: :delete
#which easy for
link_to "Deletethisbid", [auction, bid], method: :delete

auction = Auction.find(params[:auction_id] )
bid = auction.bids.find(params[:id] ) #preventsauction/bidmismatch
http://localhost:3000/auctions/5/bids/new
```

how to use the nested resource
#### chart

![screen shot 2013-09-29 at 10 58 29 pm](https://f.cloud.github.com/assets/83296/1234530/46455bb6-297c-11e3-8e98-ab7021b110df.png)

#### how to use patch & delete

used jquery-ujs

```ruby
link_to "Delete", auction_path(auction), method: :delete
```

```ruby
form_for "auction", url: auction_path(auction), html: { method: :patch } do |f|
end
```
### sample

```ruby
rake routes
```

![screen shot 2013-09-29 at 11 04 33 pm](https://f.cloud.github.com/assets/83296/1234544/112cd0fc-297d-11e3-9e44-e05358abe3a9.png)



