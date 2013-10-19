## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework

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

