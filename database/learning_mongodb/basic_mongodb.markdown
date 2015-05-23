scheme free

```ruby
db.books.find({ "rank" : { $exists : 1} })
#search embeded document
db.books.find( { "reviews.username" : "Gautam"})
```
