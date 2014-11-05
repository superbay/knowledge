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


### Cache Keys
The keys used in a cache can be any object that responds to either :cache_key or to :to_param. You can implement the :cache_key method on your classes if you need to generate custom keys. Active Record will generate keys based on the class name and record id.

You can use Hashes and Arrays of values as cache keys.

```ruby
# This is a legal cache key

Rails.cache.read(site: "mysite", owners: [owner_1, owner_2])
```

The keys you use on Rails.cache will not be the same as those actually used with the storage engine. They may be modified with a namespace or altered to fit technology backend constraints. This means, for instance, that you can't save values with Rails.cache and then try to pull them out with the memcache-client gem. However, you also don't need to worry about exceeding the memcached size limit or violating syntax rules.
