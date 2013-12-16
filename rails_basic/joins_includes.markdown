#### kinds of same


#### eager loading vs lazy loading


```ruby

Product.joins(:category).where('category = :name', name: name)

```
