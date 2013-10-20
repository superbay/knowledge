## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework


```ruby
classCreditCard<ActiveRecord::Base before_validation on: :create do
    # Strip everything in the number except digits
self.number = number.gsub(/[^0-9]/, "") end
end

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
