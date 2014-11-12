### How to verify Hash should not have key

```ruby

[ ~/work/mobile_server (master)]$ irb
>> require 'rspec'
true
>> include RSpec::Matchers
Object < BasicObject
>> {a: 1}.should have_key(:a)
true

>> {a: 1}.should_not have_key(:b)
true

```

### the expect format of not have key


```ruby
describe Object, "#public_instance_methods" do
  it "should not raise" do
    expect{Object.public_instance_methods}.to_not raise_error(NameError)
  end
end

#deliberate failure
describe Object, "#non_existent_message" do
  it "should not raise" do
    expect{Object.non_existent_message}.to_not raise_error(NameError)
  end
end
```


### Basic usage

Here's an example using rspec-core:

```ruby
describe Order do
  it "sums the prices of the items in its line items" do
    order = Order.new
    order.add_entry(LineItem.new(:item => Item.new(
      :price => Money.new(1.11, :USD)
    )))
    order.add_entry(LineItem.new(:item => Item.new(
      :price => Money.new(2.22, :USD),
      :quantity => 2
    )))
    expect(order.total).to eq(Money.new(5.55, :USD))
  end
end
```

The describe and it methods come from rspec-core. The Order, LineItem, Item and Money classes would be from your code. The last line of the example expresses an expected outcome. If order.total == Money.new(5.55, :USD), then the example passes. If not, it fails with a message like:

```
expected: #<Money @value=5.55 @currency=:USD>
     got: #<Money @value=1.11 @currency=:USD>
     
```

## Built-in matchers

### Equivalence

```ruby
expect(actual).to eq(expected)  # passes if actual == expected
expect(actual).to eql(expected) # passes if actual.eql?(expected)
```

Note: The new expect syntax no longer supports == matcher.

### Identity

```ruby
expect(actual).to be(expected)    # passes if actual.equal?(expected)
expect(actual).to equal(expected) # passes if actual.equal?(expected)
```

### Comparisons

```
expect(actual).to be >  expected
expect(actual).to be >= expected
expect(actual).to be <= expected
expect(actual).to be <  expected
expect(actual).to be_within(delta).of(expected)
```

### Regular expressions

```
expect(actual).to match(/expression/)
```

Note: The new expect syntax no longer supports =~ matcher.

### Types/classes

```
expect(actual).to be_an_instance_of(expected)
expect(actual).to be_a_kind_of(expected)
```

### Truthiness

```
expect(actual).to be_true  # passes if actual is truthy (not nil or false)
expect(actual).to be_false # passes if actual is falsy (nil or false)
expect(actual).to be_nil   # passes if actual is nil
```

### Expecting errors

```
expect { ... }.to raise_error
expect { ... }.to raise_error(ErrorClass)
expect { ... }.to raise_error("message")
expect { ... }.to raise_error(ErrorClass, "message")
```

### Expecting throws

```
expect { ... }.to throw_symbol
expect { ... }.to throw_symbol(:symbol)
expect { ... }.to throw_symbol(:symbol, 'value')
``` 

### Yielding

```ruby
expect { |b| 5.tap(&b) }.to yield_control # passes regardless of yielded args

expect { |b| yield_if_true(true, &b) }.to yield_with_no_args # passes only if no args are yielded

expect { |b| 5.tap(&b) }.to yield_with_args(5)
expect { |b| 5.tap(&b) }.to yield_with_args(Fixnum)
expect { |b| "a string".tap(&b) }.to yield_with_args(/str/)

expect { |b| [1, 2, 3].each(&b) }.to yield_successive_args(1, 2, 3)
expect { |b| { :a => 1, :b => 2 }.each(&b) }.to yield_successive_args([:a, 1], [:b, 2])

```

### Predicate matchers

```ruby
expect(actual).to be_xxx         # passes if actual.xxx?
expect(actual).to have_xxx(:arg) # passes if actual.has_xxx?(:arg)
Ranges (Ruby >= 1.9 only)

expect(1..10).to cover(3)
```

### Collection membership

```ruby
expect(actual).to include(expected)
expect(actual).to start_with(expected)
expect(actual).to end_with(expected)
```

### Examples

```
expect([1,2,3]).to include(1)
expect([1,2,3]).to include(1, 2)
expect([1,2,3]).to start_with(1)
expect([1,2,3]).to start_with(1,2)
expect([1,2,3]).to end_with(3)
expect([1,2,3]).to end_with(2,3)
expect({:a => 'b'}).to include(:a => 'b')
expect("this string").to include("is str")
expect("this string").to start_with("this")
expect("this string").to end_with("ring")
```

## should syntax

In addition to the expect syntax, rspec-expectations continues to support the should syntax:
```
actual.should eq expected
actual.should be > 3
[1, 2, 3].should_not include 4
```

See detailed information on [the should syntax and its usage](https://github.com/rspec/rspec-expectations/blob/master/Should.md).



some thing not exactly 



```ruby
# Model

expect(@user).to have(1).error_on(:username) # checks whether there is an error in username
expect(@user.errors[:username]).to include("can't be blank") # check for the error message

# Rendering

expect(response).to render_template(:index)

# Redirecting

expect(response).to redirect_to(movies_path)

# Capybara Matchers

expect(response.body).to have_content("Hello world")
expect(response.body).to_not have_content("Hello world")

expect(response.body).to have_css("input#movie_title")
expect(response.body).to have_css("input", count: 3) # true if there are 3 input tags in response
expect(response.body).to have_css("input", maximum: 3) # true if there or fewer or equal to 3 input tags
expect(response.body).to have_css("input", minimum: 3) # true if there are minimum of 3 input tags
expect(response.body).to have_css("input", between: 1..3) # true if there 1 to 3 input tags
expect(response.body).to have_css("p a", text: "hello") # true if there is a anchor tag with text hello
expect(response.body).to have_css("p a", text: /[hH]ello(.+)/i) # true if there is a anchor tag with text matching regex

expect(response.body).to have_xpath("//a")
expect(response.body).to have_xpath("//a", href: "google.com")
expect(response.body).to have_xpath("//a[@href='google.com']")
expect(response.body).to have_xpath("//a[contains(.,'some string')]")
expect(response.body).to have_xpath("//p//a", text: /re[dab]i/i, count: 1)

# Can take both xpath and css as input and can take arguments similar to both have_css and have_xpath

expect(response.body).to have_selector(:xpath, "//p/h1")
expect(response.body).to have_selector(:css, "p a#movie_edit_path")

# For making capybara to take css as default selector

Capybara.default_selector = :css
expect(response.body).to have_selector("input") # checks for the presence of the input tag
expect(response.body).to have_selector("input", value: "Twelve Angry Men") # checks for input tag with value
expect(response.body).to_not have_selector("input")

# For making capybara to take xpath as default selector

Capybara.default_selector = :xpath
expect(response.body).to have_selector("//input") # checks for the presence of the input tag
expect(response.body).to have_selector("//input", value: "Twelve Angry Men") # checks for input tag with value

# To access elements inside form

expect(response.body).to have_field("FirstName") # checks for presence of a input field named FirstName in a form
expect(response.body).to have_field("FirstName", value: "Rambo")
expect(response.body).to have_field("FirstName", with: "Rambo")

# Checking for a link

expect(response.body).to have_link("Foo")
expect(response.body).to have_link("Foo", href: "google.com")
expect(response.body).to_not have_link("Foo", href: "google.com")



```
