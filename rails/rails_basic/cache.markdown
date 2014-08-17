### regular cache


```ruby
response = Rails.cache.fetch("blog_#{blog_id}", :expires_in => 15.minutes){client.get_blog(blog_id)}
```

### How to clear the cache

```ruby

Rails.cache.delete("blog_#{blog_id}")

```


### How to clear fragment cache

if you have fragment cache like:

```ruby
cache [@article, 'body'] do
  = render 'article' content: @article.content
end

```

manually expire should be

```


ActionController::Base.new.expire_fragment(key)
#key = [@article, 'body']
```

[reference](http://api.rubyonrails.org/classes/ActionController/Caching/Fragments.html#M000438)
