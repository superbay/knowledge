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


### fresh_when(record_or_options, additional_options = {}) Link
Sets the etag, last_modified, or both on the response and renders a 304 Not Modified response if the request is already fresh.

Parameters:

:etag.

:last_modified.

:public By default the Cache-Control header is private, set this to true if you want your application to be cachable by other devices (proxy caches).

:template By default, the template digest for the current controller/action is included in ETags. If the action renders a different template, you can include its digest instead. If the action doesn't render a template at all, you can pass template: false to skip any attempt to check for a template digest.


Example:
```ruby
def show
  @article = Article.find(params[:id])
  fresh_when(etag: @article, last_modified: @article.created_at, public: true)
end
```
This will render the show template if the request isn't sending a matching ETag or If-Modified-Since header and just a 304 Not Modified response if there's a match.

You can also just pass a record where last_modified will be set by calling updated_at and the etag by passing the object itself.
```ruby
def show
  @article = Article.find(params[:id])
  fresh_when(@article)
end
```
When passing a record, you can still set whether the public header:

```ruby
def show
  @article = Article.find(params[:id])
  fresh_when(@article, public: true)
end
```
When rendering a different template than the default controller/action style, you can indicate which digest to include in the ETag:

```ruby 
 before_action { fresh_when @article, template: 'widgets/show' }
```

### stale?(record_or_options, additional_options = {}) Link

Sets the etag and/or last_modified on the response and checks it against the client request. If the request doesn't match the options provided, the request is considered stale and should be generated from scratch. Otherwise, it's fresh and we don't need to generate anything and a reply of 304 Not Modified is sent.

Parameters:

:etag.

:last_modified.

:public By default the Cache-Control header is private, set this to true if you want your application to be cachable by other devices (proxy caches).

:template By default, the template digest for the current controller/action is included in ETags. If the action renders a different template, you can include its digest instead. If the action doesn't render a template at all, you can pass template: false to skip any attempt to check for a template digest.

Example:

```ruby
def show
  @article = Article.find(params[:id])

  if stale?(etag: @article, last_modified: @article.created_at)
    @statistics = @article.really_expensive_call
    respond_to do |format|
      # all the supported formats
    end
  end
end
```

You can also just pass a record where last_modified will be set by calling updated_at and the etag by passing the object itself.

```ruby
def show
  @article = Article.find(params[:id])

  if stale?(@article)
    @statistics = @article.really_expensive_call
    respond_to do |format|
      # all the supported formats
    end
  end
end
```

When passing a record, you can still set whether the public header:

```ruby
def show
  @article = Article.find(params[:id])

  if stale?(@article, public: true)
    @statistics = @article.really_expensive_call
    respond_to do |format|
      # all the supported formats
    end
  end
end
```

When rendering a different template than the default controller/action style, you can indicate which digest to include in the ETag:

```ruby
def show
  super if stale? @article, template: 'widgets/show'
end
```
