## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework

#### UUID type attribute

```ruby
add_column :table_name, :unique_identifier, :uuid
```

#### other PostgreSQL type

```ruby
class CreateNetworkAddresses < ActiveRecord::Migration 
  def change
    create_table :network_addresses do |t|
      t.inet :inet_address
      t.cidr :cidr_address
      t.macaddr :mac_address
    end 
  end
end
```

#### Range Attributes

```ruby
• daterange 
• int4range 
• int8range 
• numrange 
• tsrange
• tstzrange
```

#### Json type attributes

```ruby
add_column: users, :preferences, :json
user = User.create(preferences: { color: "blue" } )
```



#### PostgreSQL 

```ruby
class AddTagsToArticles < ActiveRecord::Migration
  def change
    change_table :articles do |t| 
      t.string :tags, array: true
    end 
  end
end
#ALTERTABLE"articles"ADDCOLUMN"tags"charactervarying(255)[]
```

#### Search in array

```ruby
Article.where("'rails'=ANY(tags)")
#Alternatively, the ALL method searches for arrays where all values in the array equal the value specified.
Article.where("'rails'=ALL(tags)")
```

#### the PostgreSQL index

```ruby
add_index :photos, :properties, using: :gin 
#or
add_index :photos, :properties, using: :gist
```
GIN and GiST indexes support queries with @>, ?, ?& and ?| operators.


#### PostgreSQL enhancements

```ruby
class AddHstoreExtension < ActiveRecord::Migration
  def change
    enable_extension "hstore" 
  end
end

class AddPropertiesToPhotos < ActiveRecord::Migration
  change_table :photos do |t|
    t.hstore :properties 
  end
end
```

#### query hstore

```ruby
#Non-Indexedquerytofindallphotosthathaveakey'aperture'witha
#valueoff/1.4
Photo.where("properties->:key=:value",key:'aperture',value:'f/1.4')

#Indexedquerytofindallphotosthathaveakey'aperture'withavalue
#off/1.4
Photo.where("properties@>'aperture=>f/1.4'")

#Allphotosthathaveakey'aperture'inproperties
Photo.where("properties?:key",key:'aperture')

#Allphotosthatdonothaveakey'aperture'inproperties
Photo.where("notproperties?:key",key:'aperture')

#Allphotosthatcontainsallkeys'aperture'and'shutter_speed'
Photo.where("properties?&ARRAY[:keys]",keys:%w(apertureshutter_speed))

#Allphotosthatcontainsanyofthekeys'aperture'or'shutter_speed'
Photo.where("properties?|ARRAY[:keys]",keys:%w(apertureshutter_speed))
```


#### Non-persisted Models

```ruby
class Contact
  extend ActiveModel::Naming
  extend ActiveModel::Translation 
  include ActiveModel::Conversion 
  include ActiveModel::Validations
  
  attr_accessor :name, :email, :message
  validates :name, presence: true validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ },
    presence: true
  validates :message, length: {maximum: 1000}, presence: true

  def initialize(attributes = {}) 
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted? 
    false
  end 
end
```

or the new rails4 version

```ruby
class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :message
  validates :name, presence: true 
  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ },
    presence: true
  validates :message, length: {maximum: 1000}, presence: true
end
```

### Immutability

It’s also important to treat value objects as immutable. Don’t allow them to be changed after creation. Instead, create a new object instance with the new value instead. Active Record will not persist value objects that have been changed through means other than the writer method on the parent object.

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

```ruby
class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t| 
      t.integer :cents
      t.string :currency
    end
  end
end

>> expense = Expense.create(cost: Money.new(1000,"USD")) 
>> cost = expense.cost
>> cost.cents
=> 1000
>> expense.currency 
=> "USD"
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

### Single Table Inheritance(STI)

[Read in detail](../tech_talk/single_table_inheritance.markdown)


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

```ruby
Championship.joins(:matches).includes(:matches)
  .group('championship_id').having('count(*) >= ?', 5).order('count(*) DESC').all
```

`where.not` is a new usage, and the `Person.having.group.minimum` also not use all


```ruby
Order.select("date(created_at) as ordered_date, sum(price) as total_price").group("date(created_at)")

```

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

### more callback

callback without method

```ruby
class Firm < ActiveRecord::Base
  # Destroys the associated clients and people when the firm is destroyed
  before_destroy { |record| Person.destroy_all "firm_id = #{record.id}"   }
  before_destroy { |record| Client.destroy_all "client_of = #{record.id}" }
end
```

callback with proc check

```ruby
class User < ActiveRecord::Base

  after_create :send_welcome_email, unless: :is_celebrant?
  after_create :send_welcome_email, unless: "is_celebrant?"
  after_create :send_welcome_email, unless: Proc.new { self.role == "Celebrant" }

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
