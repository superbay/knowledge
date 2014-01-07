### subject

If you have several tests related to the same subject use subject{} to DRY them up. 


```ruby

subject(:hero) { Hero.first }
it "carries a sword" do
  expect(hero.equipment).to include "sword"
end

```


### Use let and let!

When you have to assign a variable instead of using a before block to create an instance variable, use let. Using let the variable lazy loads only when it is used the first time in the test and get cached until that specific test is finished. A really good and deep description of what let can be found in this [stackoverflow answer](http://stackoverflow.com/questions/5359558/when-to-use-rspec-let/5359979#5359979). 


```ruby
describe '#type_id' do
  let(:resource) { FactoryGirl.create :device }
  let(:type)     { Type.find resource.type_id }

  it 'sets the type_id field' do
    expect(resource.type_id).to equal(type.id)
  end
end

```

other case:


```ruby
context 'when updates a not existing property value' do
  let(:properties) { { id: Settings.resource_id, value: 'on'} }

  def update
    resource.properties = properties
  end

  it 'raises a not found error' do
    expect { update }.to raise_error Mongoid::Errors::DocumentNotFound
  end
end
```

 Use let! if you want to define the variable when the block is defined. This can be useful to populate your database to test queries or scopes.

Here an example of what let actually is. 

```ruby

# this:
let(:foo) { Foo.new }

# is very nearly equivalent to this:
def foo
  @foo ||= Foo.new
end

```

