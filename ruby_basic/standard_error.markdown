### custom ruby error & exception


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
