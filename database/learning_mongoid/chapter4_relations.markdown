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
