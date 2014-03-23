Before reading this wiki page, please see the [getting started](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md) file, which seems to be more up-to-date.

## Defining Factories

You can add factories to any of the following places:

* test/factories.rb (Test::Unit)
* spec/factories.rb (RSpec)
* test/factories/*.rb
* spec/factories/*.rb

A typical factory file looks like this:

```ruby
FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name  'Doe'
    age        { 1 + rand(100) }
        
    # Child of :user factory, since it's in the `factory :user` block
    factory :admin do
      admin true
    end
  end
end
```

Make sure to add this to your RSpec configure block:

```ruby
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
```

Make sure to add this for Test::Unit:

```ruby
class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end
```

Make sure to add this for Cucumber (an appropriate place is in the env.rb file):

```ruby
World FactoryGirl::Syntax::Methods
```

## Using factories

Once your factories are defined, you can use them in the following ways:

```ruby
# Saved instance
user = create(:user)

# Unsaved instance
user = build(:user)

# Attribute hash (ignores associations)
user_attributes = attributes_for(:user)

# Stubbed object
user_stub = build_stubbed(:user)

# Override attributes
user = create(:user, first_name: 'Joe')
```

## Sequences and associations

If you need uniqueness on a field, sequencing comes in handy.
The sequences can then be used in your other definitions

```ruby
FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password "foobar"
    password_confirmation "foobar"
  end
end
```

Or you can generate an email anywhere in your code:

```ruby
new_email = FactoryGirl.generate(:email)
```

Sequencing can also be defined within the factory definition. This lets you define a sequence that is only incremented when a new user is built or created. Otherwise, `FactoryGirl.generate(:email)` would increment the sequence.

```ruby
FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "foobar"
    password_confirmation "foobar"
  end
end
```

For completeness’ sake, we can make password_confirmation match the password by using a block to define its value.

```ruby
FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "email#{n}@factory.com" }
    password "foobar"
    password_confirmation { |u| u.password }
  end
end
```

The sequencing also works for associations. The code below will create a new user with the sequenced email from above.

```ruby
FactoryGirl.define do
  factory :post do
    name "Post name"
    user
  end
end
```

If you have a has_and_belongs_to_many relationship (e.g. people to favorite books), you may configure it as follows for person.  Use the same syntax for books:

```ruby
FactoryGirl.define do
  factory :person do
    first_name { 'James' }
    books {
      Array(5..10).sample.times.map do
        FactoryGirl.create(:book) # optionally add traits: FactoryGirl.create(:book, :book_description)
      end
    }
  end
end
```

## Aliases

For a model that has named associations, you can add an alias to a factory. For instance, consider a private message model that has a sender and recipient association for the user table

```ruby
class Message < ActiveRecord::Base
  belongs_to :sender, :class_name => "User",
             :foreign_key => 'sender_id'
  belongs_to :recipient, :class_name => "User",
             :foreign_key => 'recipient_id'
end
```

```ruby
FactoryGirl.define do
  factory :user, :aliases => [:sender, :recipient] do
    username
    password 'secret'
    password_confirmation { |u| u.password }
  end
end
```

Which then could be used as:

```ruby
FactoryGirl.define do
  factory :message do
    sender
    recipient
  end
end
```
