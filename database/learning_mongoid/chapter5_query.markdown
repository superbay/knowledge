

```ruby
Book.where(:published_date.lte => Date.today)
#old way
Book.where(:published_date => { "$lte" => Date.today })

```


search in array attributes

```ruby
Book.in(awards: ['second place']).first 
```
