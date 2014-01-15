### should respond_to


```ruby
describe "a string" do
  it { should respond_to(:length) }
  it { should respond_to(:hash, :class, :to_s) }
  it { should_not respond_to(:to_model) }
  it { should_not respond_to(:compact, :flatten) }

  # deliberate failures
  it { should respond_to(:to_model) }
  it { should respond_to(:compact, :flatten) }
  it { should_not respond_to(:length) }
  it { should_not respond_to(:hash, :class, :to_s) }

  # mixed examples--String responds to :length but not :flatten
  # both specs should fail
  it { should respond_to(:length, :flatten) }
  it { should_not respond_to(:length, :flatten) }
end


describe 7 do
  it { should respond_to(:zero?).with(0).arguments }
  it { should_not respond_to(:zero?).with(1).argument }

  it { should respond_to(:between?).with(2).arguments }
  it { should_not respond_to(:between?).with(7).arguments }

  # deliberate failures
  it { should respond_to(:zero?).with(1).argument }
  it { should_not respond_to(:zero?).with(0).arguments }

  it { should respond_to(:between?).with(7).arguments }
  it { should_not respond_to(:between?).with(2).arguments }
end
```

### have_key


```ruby
$ irb
>> require 'rspec'
true
>> include RSpec::Matchers
Object < BasicObject
>> {a: 1}.should have_key(:a)
true
```

