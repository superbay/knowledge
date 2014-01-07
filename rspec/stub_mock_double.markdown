### the way to double

```ruby
double('Article', title: 'first article', content: 'no content')
```

stub chain

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
