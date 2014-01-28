### stub helper method


```ruby

describe SomeHelper
  before :each do
    @helper = Object.new.extend SomeHelper
  end

  it "why cant i stub a helper method?!" do
    @helper.stub!(:current_user).and_return(@user)
    # ...
  end
end

```



### the way to double

```ruby
double('Article', title: 'first article', content: 'no content')
```

other way to explain double with value

```ruby
describe "a simple stub with a return value" do
  context "specified in a block" do
    it "returns the specified value" do
      receiver = double("receiver")
      receiver.stub(:message) { :return_value }
      receiver.message.should eq(:return_value)
    end
  end

  context "specified in the double declaration" do
    it "returns the specified value" do
      receiver = double("receiver", message: :return_value)
      receiver.message.should eq(:return_value)
    end
  end

  context "specified with and_return" do
    it "returns the specified value" do
      receiver = double("receiver")
      receiver.stub(:message).and_return(:return_value)
      receiver.message.should eq(:return_value)
    end
  end
end
```


### stub chain

```ruby
describe "stubbing a chain of methods" do
  subject { Object.new }

  context "given symbols representing methods" do
    it "returns the correct value" do
      subject.stub_chain(:one, :two, :three).and_return(:four)
      subject.one.two.three.should eq(:four)
    end
  end

  context "given a string of methods separated by dots" do
    it "returns the correct value" do
      subject.stub_chain("one.two.three").and_return(:four)
      subject.one.two.three.should eq(:four)
    end
  end
end
```
