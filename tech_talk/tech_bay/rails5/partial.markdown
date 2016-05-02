


### Rails 5 makes rendering partial from cache substantially faster

Let’s have a look at Rails view code that renders partial using a collection.

```ruby
# index.html.erb
<%= render partial: 'todo', collection: @todos %>

# _todo.html.erb
<% cache todo do %>
  <%= todo.name %>
<% end %>
```


In the above case Rails will do one fetch from the cache for each todo.

Fetch is usually pretty fast with any caching solution, however, one fetch per todo can make the app slow.

Gem [multi_fetch_fragments](https://github.com/n8/multi_fetch_fragments) fixed this issue by using [read_multi](http://api.rubyonrails.org/classes/ActiveSupport/Cache/Store.html#method-i-read_multi) api provided by Rails.

In a single call to cache, this gem fetches all the cache fragments for a collection. The author of the gem saw [78% speed improvement](http://ninjasandrobots.com/rails-faster-partial-rendering-and-caching) by using this gem.

The features of this gem [have been folded into Rails 5](https://github.com/rails/rails/pull/18948).

To get benefits of collection caching, just add `cached: true` as shown below.

```ruby
# index.html.erb
<%= render partial: 'todo', collection: @todos, cached: true %>

# _todo.html.erb
<% cache todo do %>
  <%= todo.name %>
<% end %>
```

With `cached: true` present, Rails will use read_multi to the cache store instead of reading from it every partial.

Rails will also log cache hits in the logs as below.

```
  Rendered collection of todos/_todo.html.erb [100 / 100 cache hits] (339.5ms)
```

Checkout the pull request to gain better understanding about how collection caching works.

## Suppress save events in Rails 5

Rails 5 added [suppress](https://github.com/rails/rails/pull/18910) method which is used to prevent the receiver from being saved during the given block.
Use case for suppress method

Let’s say, we have an E-commerce application, which has many products. Whenever new product is launched then subscribed customers are notified about it.

```
class Product < ApplicationRecord
  has_many :notifications
  belongs_to :seller

  after_save :send_notification

  def launch!
    update_attributes!(launched: true)
  end

  private

  def send_notification
    notifications.create(message: 'New product Launched', seller: seller)
  end
end

class Notification < ApplicationRecord
  belongs_to :product
  belongs_to :seller

  after_create :send_notifications

  private

  def send_notifications
    # Sends notification about product to customers.
  end
end

class Seller < ApplicationRecord
  has_many :products
end
```


This creates a notification record every time we launch a product.

```
>> Notification.count
=> 0

>> seller = Seller.last
=> <Seller id: 6, name: "John">

>> product = seller.products.create(name: 'baseball hat')
=> <Product id: 4, name: "baseball hat", seller_id: 6>

>> product.launch!

>> Notification.count
=> 1
```

Now, we have a situation where we need to launch a product but we don’t want to send notifications about it.

Before Rails 5, this was possible only by adding more conditions.
ActiveRecord::Base.Suppress in Rails 5

In Rails 5, we can use ActiveRecord::Base.suppress method to suppress creating of notifications as shown below.

```
class Product < ApplicationRecord
  def launch_without_notifications
    Notification.suppress do
      launch!
    end
  end
end

>> Notification.count
=> 0

>> product = Product.create!(name: 'tennis hat')
=> <Event id: 1, name: "tennis hat">

>> product.launch_without_notifications

>> Notification.count
=> 0
```

As we can see, no new notifications were created when product is launched inside Notification.suppress block.

Checkout the pull request to gain better understanding of how suppress works.



## Support for left outer join in Rails 5

Suppose in a blog application there are authors and posts. A post belongs to an author, while author has many posts.

The app needs to show a list of all the authors along with a number of posts that they have written.

For this, we need to join author and posts table with “left outer join”. More about “left outer join” here, here and here .

In Rails 4.x, we need to write the SQL for left outer join manually as Active Record does not have support for outer joins.

```
authors = Author.join('LEFT OUTER JOIN "posts" ON "posts"."author_id" = "authors"."id"')
                .uniq
                .select("authors.*, COUNT(posts.*) as posts_count")
                .group("authors.id")
```

Rails 5 has added [left_outer_joins](https://github.com/rails/rails/pull/12071) method.

```
authors = Author.left_outer_joins(:posts)
                .uniq
                .select("authors.*, COUNT(posts.*) as posts_count")
                .group("authors.id")
```

It also allows to perform the left join on multiple tables at the same time.

```
>> Author.left_joins :posts, :comments
  Author Load (0.1ms)  SELECT "authors".* FROM "authors" LEFT OUTER JOIN "posts" ON "posts"."author_id" = "authors"."id" LEFT OUTER JOIN "comments" ON "comments"."author_id" = "authors"."id"
```

If you feel `left_outer_joins` is too long to type, then Rails 5 also has an alias method `left_joins`.
