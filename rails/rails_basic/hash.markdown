### more convenient way


```ruby
define Hash#with_indifferent_access

```

Note that core extensions 

```ruby
rgb = { black: '#000000', white: '#FFFFFF' }.with_indifferent_access

```
which may be handy.

### require 


```ruby
require 'active_support/core_ext/hash/indifferent_access'
```

### hash with symbole and array



```ruby
HashWithIndifferentAccess.new


rgb = ActiveSupport::HashWithIndifferentAccess.new

rgb[:black] = '#000000'
rgb[:black]  # => '#000000'
rgb['black'] # => '#000000'

rgb['white'] = '#FFFFFF'
rgb[:white]  # => '#FFFFFF'
rgb['white'] # => '#FFFFFF'
```


[official instruction](http://api.rubyonrails.org/classes/ActiveSupport/HashWithIndifferentAccess.html)



If you need to allow for a object.content.nil? then you'd use try. If you want to allow for a missing key then you don't want fetch (as Priti notes), you want the normal [] method. Combining the two yields:

```ruby
object.content.try(:[], 'en')
```


Observe:

```ruby
> h = { :a => :b }
 => {:a=>:b} 

> h.try(:[], :a)
 => :b 

> h.try(:[], :c)
 => nil 

> h = nil
 => nil 

> h.try(:[], :a)
 => nil
```

[dynamic call a hash](../ruby_basic/meta_program.markdown)
