scheme free

```ruby
db.books.find({ "rank" : { $exists : 1} })
#search embeded document
db.books.find( { "reviews.username" : "Gautam"})

db.books.find( { category_ids : { $in : [
ObjectId("4e86e4cbfed0eb0be0000012"),
ObjectId("4e86e4d9fed0eb0be0000013")
] } } )

db.books.find( { category_ids : { $nin : [
ObjectId("555555555555555555555555"),
ObjectId("666666666666666666666666")
] } } )

db.books.find( { category_ids : { $all : [
ObjectId("4e86e4cbfed0eb0be0000012"),
ObjectId("4e86e4d9fed0eb0be0000013")
] } } )
```


```ruby
db.names.find({ name : /^Jo/i} )

```
