## Active Record Associations

#### touch: true

Used to updated the corresponding foreign key to expire the relation cache
```bash
rails generate migration AddTimesheetsUpdatedAtToUsers timesheets_updated_at:datetime
invoke active_record
create db/migrate/20130413175038_add_timesheets_updated_at_to_users.rb
```

```ruby

class Timesheet < ActiveRecord::Base
  belongs_to :user, touch: :timesheets_updated_at 
  #...
end
```
will update User: timesheets_updated_at attributes while Timesheet updated


### Fine explain polymorphic

```ruby
create_table :comments do |t|
  t.text :body
  t.references :subject, polymorphic: true
  # references can be used as a shortcut for following two statements
  # t.integer :subject_id
  # t.string  :subject_type
  t.timestamps
end

class Comment < ActiveRecord::Base
  # two references attributes located, id && type used to find the relation
  belongs_to :subject, polymorphic: true
end

class ExpenseReport < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :subject
end

class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :subject
end
```

#### select

```ruby
user.timesheets.select(:submitted).to_a
Client.select(:id).map { |c| c.id }
# or
Client.select(:id).map(&:id)
# or
Client.select(:id, :name).map { |c| [c.id, c.name] }
```

#### pluck

```ruby
Client.where(active: true).pluck(:id)
# SELECT id FROM clients WHERE active = 1
# => [1, 2, 3]
 
Client.distinct.pluck(:role)
# SELECT DISTINCT role FROM clients
# => ['admin', 'member', 'guest']
 
Client.pluck(:id, :name)
# SELECT clients.id, clients.name FROM clients
# => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]
```

#### relation build or create
```ruby
user.timesheets.build(attributes)
user.timesheets.new(attributes)#sameascallingbuild
```

#### first with number

```ruby
c.billing_codes.first(2)
```
