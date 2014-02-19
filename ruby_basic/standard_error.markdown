### custom ruby error & exception


```ruby
class MyCustomError < StandardError
end
```

This allows you to raise it using:

```ruby
raise MyCustomError, "A message"
```

and later, get that message when rescuing

```ruby
rescue Exception => e
  puts e.message # => "A message"
```

full example

```ruby
class MyCustomError < StandardError
  attr_reader :object

  def initialize(object)
    @object = object
  end
end

begin
  raise MyCustomError.new("an object"), "a message"
rescue Exception => e
  puts e.message # => "a message"
  puts e.object # => "an object"
end
```
