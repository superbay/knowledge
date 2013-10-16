## Validations

#### validation

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
