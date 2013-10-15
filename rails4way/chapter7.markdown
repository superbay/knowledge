## Active Record Associations


#### aggregation associations

```ruby
class User < ActiveRecord::Base
  has_many :timesheets
  has_many :billable_weeks, through: :timesheets
end 

class Timesheet < ActiveRecord::Base
  belongs_to :user
  has_many :billable_weeks, -> { include(:billing_code) }

end
```

#### aggregation associations create

```ruby
ts2=quentin.timesheets.create
 #<Timesheetid:2...>

ts2.billable_weeks.create(start_date:1.week.ago)
```

create billiable_weeks with the relation ship

#### aggregation associations create

#### self referencial relation

```ruby
class CreateRelatedBillingCodes < ActiveRecord::Migration
  def change
    create_table :related_billing_codes, id: false do |t|
      t.column :first_billing_code_id, :integer, null: false 
      t.column :second_billing_code_id, :integer, null: false
    end 
  end
end

class BillingCode < ActiveRecord::Base
  has_and_belongs_to_many :related,
    join_table: 'related_billing_codes',
    foreign_key: 'first_billing_code_id',
    association_foreign_key: 'second_billing_code_id',
    class_name: 'BillingCode'
end
```

#### has_many relations with call_back

```ruby
class Timesheet < ActiveRecord::Base
  has_many :unchangable_posts, class_name: "Post",
           before_add: :raise_exception
           
  has_many :unchangable_posts, class_name: "Post",
           before_add: ->(owner, record) { raise "Can't do it!" }
           
  has_many :timesheets, inverse_of: :user

private
  def raise_exception(object)
    raise "You can't add a post"
  end
end
```


#### belongs_to && has_many witch scope

```ruby
class Timesheet < ActiveRecord::Base 
  belongs_to :approver,
    -> { where(approver: true) },
    class_name: 'User'
  #...
  belongs_to :post, -> { includes(:author) }
  has_many :pending_comments, -> { where(approved:true) }, class_name: 'Comment'
  has_many :posts, -> { includes( [:author, {comments: {author::avatar}}]) }
end
```

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
