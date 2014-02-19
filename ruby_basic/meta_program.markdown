### How to dynamic call a hash


```ruby

hash = {color: 'blue', size: 5}

attrs = %w('color', 'size')

attrs.map do |attr|
  hash.try :[], attr 
end
```


call the hash


```ruby
1.9.2p320 :013 > hash = {color: 'blue', size: 5}
 => {:color=>"blue", :size=>5}

1.9.2p320 :014 > co = 'color'
 => "color"

1.9.2p320 :015 > hash.send :[], co.to_sym
 => "blue"
```

### alias

```ruby
alias_method "memoized_#{name}", name
```
