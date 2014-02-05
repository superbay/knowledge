### regular cache


```ruby
response = Rails.cache.fetch("blog_#{blog_id}", :expire_in => 15.minutes){client.get_blog(blog_id)}
```


### How to clear fragment cache

```
ActionController::Base.new.expire_fragment(key)
```

[reference](http://api.rubyonrails.org/classes/ActionController/Caching/Fragments.html#M000438)
