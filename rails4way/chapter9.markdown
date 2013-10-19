## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework

#### scope combination
```ruby
scope :late, ->{ where("timesheet.submitted_at<=?", 7.days.ago) }
#Then we use our new late scope in tardy:
scope :tardy, ->{ 
  joins(:timesheets).group("users.id").merge(Timesheet.late)
}
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
