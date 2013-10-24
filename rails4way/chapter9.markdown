## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework

### Immutability

```ruby
class Expense < ActiveRecord::Base 
  def cost
    @cost ||= Money.new(cents || 0, currency || Money.default_currency) 
  end
  
  def cost=(cost)
    self[:cents] = cost.cents 
    self[:currency] = cost.currency.to_s
    cost
  end 
end
```

#### Modifying Active Record at Runtime

```ruby
classAccount<ActiveRecord::Base ...
  protected
  def after_find
    singleton = class << self; self; end
    singleton.class_eval(config)
  end 
end
```

#### Single Table Inheritance(STI)
```ruby
class Timesheet < ActiveRecord::Base
  def billable_hours_outstanding
    if submitted?
      billable_weeks.map(&:total_hours).sum
    else
      0
    end
  end

  def self.billable_hours_outstanding_for(user) 
    user.timesheets.map(&:billable_hours_outstanding).sum
  end 
end
```

If there is requirement of paid then, We 

```ruby
def billable_hours_outstanding
  if submitted? && not paid?
    billable_weeks.map(&:total_hours).sum
  else
    0
  end
end
```
#### Single Table Inheritance way

```ruby
class Timesheet < ActiveRecord::Base 
  # non-relevant code ommitted
  def self.billable_hours_outstanding_for(user)   
    user.timesheets.map(&:billable_hours_outstanding).sum
  end 
end

class DraftTimesheet < Timesheet
  def billable_hours_outstanding
    0
  end
end

class SubmittedTimesheet < Timesheet
  def billable_hours_outstanding
    billable_weeks.map(&:total_hours).sum
  end
end
```

While there is new requirement

```ruby
class PaidTimesheet < Timesheet 
  def billable_hours_outstanding
    billable_weeks.map(&:total_hours).sum - paid_hours 
  end
end
```

still need:

```ruby
class AddTypeToTimesheet < ActiveRecord::Migration 
  def change
    add_column :timesheets, :type, :string 
  end
end
```

Then, automaticly have this:

```ruby
>> d = DraftTimesheet.create
>> d.type 
=> 'DraftTimesheet'
```

and

```ruby
>> Timesheet.first
=>#<DraftTimesheet:0x2212354...>
```

#### Calculation Methods

```ruby
Person.calculate(:count, :all) # The same as Person.count
# SELECT AVG(age) FROM people
Person.average(:age)
# Selects the minimum age for everyone with a last name other than 'Drake'
Person.where.not(last_name: 'Drake').minimum(:age)
# Selects the minimum age for any family without any minors
Person.having('min(age) > 17').group(:last_name).minimum(:age)
```

`where.not` is a new usage, and the `Person.having.group.minimum` also not use all

#### Test 

```ruby
escribe '#after_create' do
  let(:auditable) { double() }
  let(:log) { double() }
  let(:content) { 'foo' }
  it 'audits a model was created' do 
    auditable.should_receive(:inspect).and_return(content)
    log.should_receive(:created).and_return(content)
    Auditor.new(log).after_create(auditable)
  end 
end
```

```ruby
class ActiveRecord::Base
  def self.acts_as_audited(audit_log=DEFAULT_AUDIT_LOG)
    auditor = Auditor.new(audit_log)
    after_create auditor
    after_update auditor
    after_destroy auditor
  end 
end
```

#### Callback Class

```ruby
class MarkDeleted
   def self.before_destroy(model)
     model.update_attribute(:deleted_at, Time.zone.now)
     false 
   end
end
```

#### Paranoia with before destroy

```ruby
class Account < ActiveRecord::Base 
  before_destroy do
    self.update_attribute(:deleted_at, Time.zone.now)
    false 
  end
#... 
end

```


#### geo call back example

```ruby
class Address < ActiveRecord::Base
  before_save :geocode
  validates_presence_of :street, :city, :state, :country
  #...
  def to_s
    [street, city, state, country].compact.join(', ')
  end
protected
  def geocode1
    result = Geocoder.coordinates(to_s) 
    self.latitude = result.first 
    self.longitude = result.last
  end 
  
  def geolocate
    result = Geocoder.coordinates(to_s) 
    if result.present?
      self.latitude = result.first
      self.longitude = result.last 
    else
      errors[:base] << "Geocoding failed. Please check address."
      false 
    end
  end
end

```




example of using call back
```ruby
class CreditCard < ActiveRecord::Base
  before_validation on: :create do
    # Strip everything in the number except digits
    self.number = number.gsub(/[^0-9]/, "") 
  end
end
```

#### call back list

```ruby
• before_validation 
• after_validation 
• before_save
• around_save
• before_create #(for new records) and before_update (for existing records) 
• around_create #(for new records) and around_update (for existing records) 
• after_create #(for new records) and after_update (for existing records)
• after_save
```

#### call back

will not trigger call back
```
• decrement
• decrement_counter • delete
• delete_all
• increment
• increment_counter • toggle
• touch
• update_column
• update_columns
• update_all
• update_counters

```

#### one-lines 

```ruby
class Account < ActiveRecord::Base
  before_destroy { self.update_attribute(:deleted_at, Time.now); false }
end
```

#### define of weather

```ruby
class Beethoven < ActiveRecord::Base before_destroy :last_words
protected
  def last_words
    logger.info "Friends applaud, the comedy is over"
  end 
end
```

#### scope combination
```ruby
scope :late, ->{ where("timesheet.submitted_at<=?", 7.days.ago) }
#Then we use our new late scope in tardy:
scope :tardy, ->{ 
  joins(:timesheets).group("users.id").merge(Timesheet.late)
}
```

#### default scope

```ruby
classTimesheet < ActiveRecord::Base
  default_scope { where(status: "open") }
end

#### possible 
Time sheet.unscoped.order("submitted_atDESC").to_a
#=>[#<Timesheetid:2,status:"submitted">]
```

#### Advanced index

callbacks, single-table inheritance (STI), and polymorphic models.

#### scope

```ruby
class Timesheet < ActiveRecord::Base
  scope :submitted, -> { where(submitted: true) }
  scope :underutilized, -> { where('total_hours < 40') }
end

class BillableWeek < ActiveRecord::Base
  scope :newer_than, ->(date) { where('start_date > ?', date) }
end

```


#### define of scope

```ruby
scope:tardy,->{
  joins(:timesheets). 
  where("timesheets.submitted_at <= ?", 7.days.ago). 
  group("users.id")
}

# the actually sql script query is
User.tardy.to_sql
#=>"SELECT "users".* FROM "users" INNER JOIN "timesheets" ON "timesheets"."user_id" = "users"."id" WHERE (timesheets.submitted_at <= '2013-04-13 18:16:15.203293') GROUP BY users.id" # query formatted nicely for the book
```
