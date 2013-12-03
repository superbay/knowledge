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
