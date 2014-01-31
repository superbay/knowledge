### regular cache


```ruby
response = Rails.cache.fetch("blog_#{blog_id}", :expire_in => 15.minutes){client.get_blog(blog_id)}
```
