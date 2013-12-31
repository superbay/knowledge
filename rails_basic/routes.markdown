### nested route


```ruby
  resources :products do
    member do 
      get :delete
      delete :delete, action: :destroy
    end
  end
```
