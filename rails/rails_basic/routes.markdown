### about nested routes


```ruby
resources :cars do
  resources :reviews
end

resources :motorcycles do
  resources :reviews
end
```

the path should be


```ruby

link_to "Show", [@parent, @review]

```

but edit will be

```ruby
edit_polymorphic_path([@parent, @review]) 
#or
link_to 'Edit Review', [:edit, @parent, @review]

link_to 'Edit Review', edit_review_path([@reviewable, :reviews])
```

However, That dose not include shallow and more customized nested resource

```ruby
    resources :blood_drives do 
       post 'add_donor', on: :member
       get 'add_donor', on: :member
       delete 'delete_donor', on: :member
       resources :donors, only: [:destroy]
     end
     
```   

and

### shallow nesting

http://edgeguides.rubyonrails.org/routing.html

```ruby
shallow do
  resources :posts do
    resources :comments
    resources :quotes
    resources :drafts
  end
end
```

http://rails-bestpractices.com/posts/11-needless-deep-nesting

### hack your route

should added two more routes

```ruby
module DeleteResourceRoute
  def resources(*args, &block)
    super(*args) do
      yield if block_given?
      member do
        get :delete
        delete :delete, action: :destroy
      end
    end
  end
end

ActionDispatch::Routing::Mapper.send(:include, DeleteResourceRoute)


```

### If you want use format to distinguish the route


```ruby
match '*pages' => 'pages#show', :format => false
```

you can get more explain [here](http://guides.rubyonrails.org/routing.html#request-based-constraints)

#### constrains

```ruby
get 'photos', constraints: {subdomain: 'admin'}


namespace :admin do
  constraints subdomain: 'admin' do
    resources :photos
  end
end
```


### nested route


```ruby
  resources :products do
    member do 
      get :delete
      delete :delete, action: :destroy
    end
  end
```


The url generate would be


```ruby
<%= link_to "Destroy", [:delete, product], method: :delete, data: {confirm: "Are you sure?"} %>
#or
delete_product_path

```



the rake routes

```ruby
delete_product GET    /products/:id/delete(.:format) products#delete                                                                                                  
               DELETE /products/:id/delete(.:format) products#destroy                                                                                                 
      products GET    /products(.:format)            products#index                                                                                                   
               POST   /products(.:format)            products#create                                                                                                  
   new_product GET    /products/new(.:format)        products#new                                                                                                     
  edit_product GET    /products/:id/edit(.:format)   products#edit                                                                                                    
       product GET    /products/:id(.:format)        products#show                                                                                                    
               PUT    /products/:id(.:format)        products#update                                                                                                  
               DELETE /products/:id(.:format)        products#destroy   
```
