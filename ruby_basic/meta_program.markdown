### How to dynamic call a hash


```ruby

hash = {color: 'blue', size: 5}

attrs = %w('color', 'size')

attrs.map do |attr|
  hash.try :[], attr 
end
```
