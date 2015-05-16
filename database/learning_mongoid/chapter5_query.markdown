

```ruby
Book.where(:published_date.lte => Date.today)
#old way
Book.where(:published_date => { "$lte" => Date.today })

```
