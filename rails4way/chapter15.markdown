## security


#### Model mass-assignment attributes protection

```ruby
def create_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
def update_params
  params.require(:user).permit(name: true, email: true, tags: [])
end


```


#### SQL injection


```ruby
class ProductsController < ApplicationController
  def search
    @products = Product.where("name LIKE '%#{params[:search_terms]}%'") end
  end

```

while input will be 

```ruby
SELECT * FROM products WHERE name LIKE'%'; DELETE FROM users; %';
```
