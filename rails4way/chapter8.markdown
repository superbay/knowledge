## Validations

#### validation

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
