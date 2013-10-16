## Validations


#### validation

#### conditional validation

```ruby
validates_presence_of :approver, if: -> { approved? && !legacy? }
```

### validate while call back

```ruby
class Account < ActiveRecord::Base
  validates_uniqueness_of :email, on: :create
end
```

#### using ActiveRecord::Validator

```ruby
class EmailValidator < ActiveRecord::Validator 
  def validate()
    record.errors[:email] << "is not valid" unless
    record.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  end 
end

class Account < ActiveRecord::Base
  validates_with EmailValidator
end
```


more generic way to the field

```ruby
class EmailValidator < ActiveRecord::Validator 
  def validate()
    email_field = options[:attr] 
    record.errors[email_field] << "is not valid" unless record.send(email_field) =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ 
  end
end

class Account < ActiveRecord::Base 
  validates_with EmailValidator, attr: :email
end
```

limit contrain lookup

```ruby
class Article < ActiveRecord::Base 
  validates_uniqueness_of :title,
    conditions: -> { where.not(published_at: nil) } 
    #...
end
```

combination validation

```ruby
class Address < ActiveRecord::Base
  validates_uniqueness_of :line_two, scope: [:line_one, :city, :zip]
end
# just like combination index. the uniqueness is not only line_two, but 4 together
```


customize validation

```ruby
class Timesheet < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id
  validate :user_exists

protected
  def user_exists
    errors.add(:user_id, "doesn't exist") unless User.exists?(user_id)
  end
end
```

```ruby
class Account < ActiveRecord::Base 
  validates_length_of :username, within: 5..20
end
```

inclusion vs exclusion

```ruby
class Person < ActiveRecord::Base
  validates_inclusion_of :gender, in: %w( m f ), message: 'O RLY?'
  #...
end

class Account < ActiveRecord::Base
  validates_exclusion_of :username, in: %w( admin superuser ),
                         message: 'Borat says "Naughty, naughty!"'
end
                         
```
