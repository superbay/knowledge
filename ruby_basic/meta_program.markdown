### How to dynamic call a hash


```ruby

hash = {color: 'blue', size: 5}

attrs = %w('color', 'size')

attrs.map do |attr|
  hash.try :[], attr 
end
```


### dynamic assign hash 

```ruby
hash.send(:[]=, week_day.to_sym, row.send(week_day))

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

### Singleton

```ruby
class Klass
   include Singleton
   # ...
end

a,b  = Klass.instance, Klass.instance

a == b
# => true

Klass.new
# => NoMethodError - new is private ...

#The instance is created at upon the first call of Klass.instance().

class OtherKlass
  include Singleton
  # ...
end

ObjectSpace.each_object(OtherKlass){}
# => 0

OtherKlass.instance
ObjectSpace.each_object(OtherKlass){}
# => 1
```
