
```ruby
Person.where('$or' => [{first_name: "Soren"}, {last_name: "White"}])
Person.any_of({first_name: "Soren"}, {last_name: "White"}).to_a
Person.or({first_name: "Soren"}, {last_name: "White"})

```


```ruby
Book.where(:published_date.lte => Date.today)
#old way
Book.where(:published_date => { "$lte" => Date.today })

```


search in array attributes

```ruby
Book.in(awards: ['second place']).first 
#or
Book.where(awards: /second plac[e/E]/).first

```

search embeded documents will be same as hash or array

```ruby
irb> b = Book.all.sample
=> #<Book _id: 51b75aaf45db7cc8b4000001, t(title): "How to deal?", ... author_id: BSON::ObjectId('5143678345db7ca255000001')>

irb> b.reviews << Review.new(content: 'awesome')
 => [#<Review _id: 527aa81433352d01f0000000, content: "awesome">]
 
irb> b.reviews << Review.new(content: 'sucks!')
 => [#<Review _id: 527aa81433352d01f0000000, content: "awesome">, #<Review _id: 527aa81a33352d01f0010000, content: "sucks!">]
Now, if we want to search inside an array of hashes or embedded documents, we can fire the query as follows:


> Book.where('reviews.content' => /awesome/).first
=> #<Book _id: 51b75aaf45db7cc8b4000001, t(title): "How to deal?", ,,, author_id: BSON::ObjectId('5143678345db7ca255000001')>
```

###scope

```ruby
scope :latest, gte(published_date: (Date.today – rand(10).years).beginning_of_year)
```

### find_and_modify

```ruby

Queue.
  where(pending: true).
  asc(:created_at).
  find_and_modify({ "$set" => { pending: false }}, new: true)
```
