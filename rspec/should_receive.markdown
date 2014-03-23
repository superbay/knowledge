# Message expectations

### new syntax

```ruby
expect(DeskCase).to receive(:fetch_case_list).and_return([])
```


### should receive with times and verify params


```ruby
Project.should_receive(:find).twice.with(@project).and_return(@project)

#for exactly n times:

Project.should_receive(:find).exactly(n).times.with(@project).and_return(@project)

#for at least n times:

Project.should_receive(:msg).at_least(n).times.with(@project).and_return(@project)

```


### Basics

```ruby
# create a double
obj = double()

# expect a message
obj.should_receive(:message)

# specify a return value
obj.should_receive(:message) { 'this is the value to return' }

book = instance_double("Book", :pages => 250)
```

```ruby
#3.0 version
# create a double
obj = double()

# specify a return value using `:expect` syntax
allow(obj).to receive(:message) { :value }
allow(obj).to receive(:message).and_return(:value)

# specify a return value using `:should` syntax
obj.stub(:message) { :value }
obj.stub(:message => :value)
obj.stub(:message).and_return(:value)
```

## Argument constraints

### Explicit arguments

```ruby
obj.should_receive(:message).with('an argument')
obj.should_receive(:message).with('more_than', 'one_argument')
```

### Argument matchers

```ruby
obj.should_receive(:message).with(anything())
obj.should_receive(:message).with(an_instance_of(Money))
obj.should_receive(:message).with(hash_including(:a => 'b'))
# version 3.0 below
allow(obj).to receive(:message).with(anything()) { ... }
allow(obj).to receive(:message).with(an_instance_of(Money)) { ... }
allow(obj).to receive(:message).with(hash_including(:a => 'b')) { ... }
allow(obj).to receive(:message).with(array_including(1,2,3)) { ... }
# or
allow(obj).to receive(:message).with(array_including([1,2,3])) { ... }

obj.stub(:message).with(anything()) { ... }
obj.stub(:message).with(an_instance_of(Money)) { ... }
obj.stub(:message).with(hash_including(:a => 'b')) { ... }
obj.stub(:message).with(array_including(1,2,3)) { ... }
# or
obj.stub(:message).with(array_including([1,2,3])) { ... }

```

### Regular expressions

```ruby
obj.should_receive(:message).with(/abc/)
allow(obj).to receive(:message).with(/abc/) { ... }

obj.stub(:message).with(/abc/) { ... }
```

### Counts

```ruby
obj.should_receive(:message).once
obj.should_receive(:message).twice
obj.should_receive(:message).exactly(3).times

obj.should_receive(:message).at_least(:once)
obj.should_receive(:message).at_least(:twice)
obj.should_receive(:message).at_least(n).times

obj.should_receive(:message).at_most(:once)
obj.should_receive(:message).at_most(:twice)
obj.should_receive(:message).at_most(n).times
```

### Raising/Throwing

```ruby
obj.should_receive(:message).and_raise("this error")
obj.should_receive(:message).and_throw(:this_symbol)

obj.should_receive(:message) { raise "this error" }
obj.should_receive(:message) { throw :this_symbol }


# version 3.0 rspec below
allow(obj).to receive(:message).and_raise("this error")
allow(obj).to receive(:message).and_throw(:this_symbol)

obj.stub(:message).and_raise("this error")
obj.stub(:message).and_throw(:this_symbol)

allow(obj).to receive(:message) { raise "this error" }
allow(obj).to receive(:message) { throw :this_symbol }

obj.stub(:message) { raise "this error" }
obj.stub(:message) { throw :this_symbol }
```

### Ordering

```ruby
obj.should_receive(:one).ordered
obj.should_receive(:two).ordered
```

### Arbitrary handling

```ruby
#Fake implementation
obj.should_receive(:message) do |arg1, arg2|
  # set expectations about the args in this block
  # and set a return value
end

allow(obj).to receive(:message) do |arg1, arg2|
  # set expectations about the args in this block
  # and/or return  value
end

obj.stub(:message) do |arg1, arg2|
  # set expectations about the args in this block
  # and/or return a value
end
```
