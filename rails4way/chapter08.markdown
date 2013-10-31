## Validations

#### test validation

```ruby
describePostdo
  it { should validate_uniqueness_of(:title) }
  it { should validate_presence_of(:body).with_message(/wtf/) }
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:user_id) }
end

describeUserdo
  it { should_not allow_value("blah").for(:email) }
  it { should_not allow_value("b lah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }
  it { should allow_value("asdf@asdf.com").for(:email) }
  it { should ensure_length_of(:email).is_at_least(1).is_at_most(100) }
  it { should ensure_inclusion_of(:age).in_range(1..100) }
end
```

```ruby
class CompletelyLameTotalExample < ActiveRecord::Base 
  def validate
    if total != (attr1 + attr2 + attr3) 
      errors[:total] << "The total doesn't add up!"
    end 
  end
end
```

```ruby
class ReportLikeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value["Report"]
      record.errors.add(attribute, 'does not appear to be a Report')
    end
  end
end

class Report < ActiveRecord::Base
  validates :name, report_like: true
end
```

```ruby
class LikeValidator < ActiveModel::EachValidator
  def initialize(options)
    @with = options[:with]
    super
  end
  def validate_each(record, attribute, value)
    unless value[@with]
      record.errors.add(attribute, "does not appear to be like #{@with}")
    end
  end
end

class Report < ActiveRecord::Base
  validates :name, like: { with: "Report" }
end

```
#### validate class
```ruby
class RandomlyValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "FAIL #1" unless first_hurdle(record)
    record.errors[:base] << "FAIL #2" unless second_hurdle(record)
    record.errors[:base] << "FAIL #3" unless third_hurdle(record)
  end
private

  def first_hurdle(record)
    rand > 0.3
  end

  def second_hurdle(record)
    rand > 0.6
  end

  def third_hurdle(record)
    rand > 0.9
  end
end

end
```
#### Short-form Validation

```ruby
validates:username,
presence:true, 
format: { with: /[A-Za-z0-9]+/ }, 
length: { minimum: 3 }, 
uniqueness: true

validates :unwanted, absence: { message: "Youshouldn'thavesetthat" }
#alias of validates_absence_of

validates :terms, acceptance: { message: 'Youmustacceptterms.' }
# alias of validates_acceptance_of

validates :email, confirmation: { message: 'Tryagain.' }
# alias of validates_confirmation_of

validates :username, exclusion: %w(adminsuperuser)
# alias of validates_exclusion_of

format: /[A-Za-z0-9]+/
# alias of validates_format_of

validates :gender, inclusion: %w(malefemale)
# alias of validates_inclusion_of

validates :username, length: 3..20
# alias of validates_length_of

validates :quantity, numericality: { message: 'Supplyanumber.' }
# alias of validates_numericality_of

validates :username, presence: { message: 'Howdoyouexpecttologin?' }
# alias of validates_presence_of

validates :quantity, uniqueness: { message: "You'reSOLonthatloginchoice,buddy!" }
# alias of validates_uniqueness_of
```

#### validation
Context can optionally be supplied to define which callbacks to test against (the context is defined on the validations using :on).
```ruby

class Person
  include ActiveModel::Validations

  attr_accessor :name
  validates_presence_of :name, on: :new
end

person = Person.new
person.valid?       # => true
person.valid?(:new) # => false
```

```ruby
class Report < ActiveRecord::Base 
  validates_presence_of :name, on: :publish
end 

class ReportsController < ApplicationController
  expose(:report)
  # POST /reports/1/publish
  
  def publish
    if report.valid? :publish
      redirect_to report, notice: "Report published" else
      flash.now.alert = "Can't publish unnamed reports!"
      render :show 
    end
  end 
end
```

#### with_options

```ruby
with_options if: :password_required? do |user| 
  user.validates_presence_of :password 
  user.validates_presence_of :password_confirmation 
  user.validates_length_of :password, within: 4..40 
  user.validates_confirmation_of :password
end
``

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
