## Advanced Active Record
Active Record is a simple object-relational mapping (ORM) framework

#### Advanced index

callbacks, single-table inheritance (STI), and polymorphic models.

#### scope

classTimesheet<ActiveRecord::Base
scope :submitted, -> { where(submitted: true) }
scope :underutilized, -> { where('total_hours < 40') }
