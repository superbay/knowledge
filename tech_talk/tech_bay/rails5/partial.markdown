


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

The features of this gem have been folded into Rails 5.

To get benefits of collection caching, just add cached: true as shown below.

# index.html.erb
<%= render partial: 'todo', collection: @todos, cached: true %>

# _todo.html.erb
<% cache todo do %>
  <%= todo.name %>
<% end %>

With cached: true present, Rails will use read_multi to the cache store instead of reading from it every partial.

Rails will also log cache hits in the logs as below.

  Rendered collection of todos/_todo.html.erb [100 / 100 cache hits] (339.5ms)

Checkout the pull request to gain better understanding about how collection caching works.
