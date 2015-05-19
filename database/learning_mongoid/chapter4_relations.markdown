```ruby


class Author
  include Mongoid::Document

  has_many :books, after_add: :send_email

  def send_email(document)
    puts "Send email: #{document.inspect}"
    puts "self: #{self.inspect}"
  end
end
```


Now, the send_email callback is called with the child object whenever a book is created. Let's take a closer look.

```ruby
irb> a = Author.last
 => #<Author _id: 519ba17d45db7c5ac9000005, name: "after1", last_name: nil, wallet: nil, password: nil> 
> a.books.create

Send email: #<Book _id: 51b2ffbe45db7cb20d000001, t(title): nil, published_date: nil, is_best_seller: false, awards: [], reviews: nil, currency: nil, author_id: "519ba17d45db7c5ac9000005">

```


### inverse_of

```ruby
class Author
  include Mongoid::Document

  has_and_belongs_to_many :followers, 
                          class_name: "Author",
                          inverse_of: :following

  has_and_belongs_to_many :following, 
           class_name: "Author",
           inverse_of: :followers

end
```

```ruby
irb> a.following << b
 => [BSON::ObjectId('4ef5ab6ffed0eb89bf000001')]
When this is done, we can see that the follower_ids object of a and the following_ids of b are updated together! This is shown in the following code:


irb> a.following
 => [#<Author _id: 4ef5ab6ffed0eb89bf000001, _type: nil, name: "Mark Twain", 
follower_ids: [BSON::ObjectId('4e86e4b6fed0eb0be0000011')], 
following_ids: []>]

irb> b.followers
 => [#<Author _id: 4e86e4b6fed0eb0be0000011, _type: nil, name: "Charles Dickens", 
follower_ids: [], 
following_ids: [BSON::ObjectId('4ef5ab6ffed0eb89bf000001')]>] 

```

using active record as below:

![screen shot 2015-05-18 at 9 33 40 pm](https://cloud.githubusercontent.com/assets/83296/7693868/32974eee-fda6-11e4-809a-edb907b0279f.png)


```ruby
class Author
  include Mongoid::Document

  embeds_many :child_authors, class_name: "Author", cyclic: true
  embedded_in :parent_author, class_name: "Author", cyclic: true

end
```

```ruby
irb> a = Author.first
 => #<Author _id: 4e86e4b6fed0eb0be0000011, _type: nil, name: "Charles Dickens">

irb> a.child_authors << Author.last
 => true

irb> a.child_authors.first.parent_author
 => #<Author _id: 4ef5ab6ffed0eb89bf000001, _type: nil, name: "Mark Twain"> 
```

We now embed an array called child_authors into the Author document, and then reference the parent using the parent_author field. We can also do the exact same thing we just saw using the following code:

```ruby
class Author
  include Mongoid::Document

  recursively_embeds_many

end
```
