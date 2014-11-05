## Active Record Associations

#### association extension

```ruby
class Account < ActiveRecord::Base 
  has_many :people do
    def named(full_name)
      first_name, last_name = full_name.split(" ", 2)
      where(first_name: first_name, last_name: last_name).first_or_create
    end 
  end
end
```

```ruby
account = Account.first 
person = account.people.named("DavidHeinemeierHansson") 
person.first_name
#=>"David"
person.last_name 
# => "Heinemeier Hansson"
```

#### has_one and has_many

```ruby
class User < ActiveRecord::Base
  has_many :timesheets
  has_one  :latest_sheet,
    -> { order('created_at desc') },
    class_name: 'Timesheet'
end
```

#### inverse_of

solve the problem of keep two instance.

```ruby
class Customer < ActiveRecord::Base
  has_many :orders
end
 
class Order < ActiveRecord::Base
  belongs_to :customer
end
#will cause below problem
c = Customer.first
o = c.orders.first
c.first_name == o.customer.first_name # => true
c.first_name = 'Manny'
c.first_name == o.customer.first_name # => false
```
The way to solve the problem

```ruby
class Customer < ActiveRecord::Base
  has_many :orders, inverse_of: :customer
end
 
class Order < ActiveRecord::Base
  belongs_to :customer, inverse_of: :orders
end
```

will not work with through or polymorphic


### :touch
If true, the associated object will be touched (the updated_at/on attributes set to now) when this record is either saved or destroyed. If you specify a symbol, that attribute will be updated with the current time in addition to the updated_at/on attribute.

### :inverse_of
Specifies the name of the has_one or has_many association on the associated object that is the inverse of this belongs_to association. Does not work in combination with the :polymorphic options. See ActiveRecord::Associations::ClassMethods's overview on Bi-directional associations for more detail.

Option examples:

```ruby
belongs_to :firm, foreign_key: "client_of"
belongs_to :person, primary_key: "name", foreign_key: "person_name"
belongs_to :author, class_name: "Person", foreign_key: "author_id"
belongs_to :valid_coupon, ->(o) { where "discounts > ?", o.payments_count },
                          class_name: "Coupon", foreign_key: "coupon_id"
belongs_to :attachable, polymorphic: true
belongs_to :project, readonly: true
belongs_to :post, counter_cache: true
belongs_to :company, touch: true
belongs_to :company, touch: :employees_last_updated_at
```


#### polymorphic associations

```ruby
class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
end
 
class Employee < ActiveRecord::Base
  has_many :pictures, as: :imageable
end
 
class Product < ActiveRecord::Base
  has_many :pictures, as: :imageable
end
```

1 ploymorhpic always with belongs_to
2 belongs_to Model have type and id, which are imageable_type, imageable_id
3 as in ActiveRecord always used while there is polymorphic

```ruby
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string  :name
      t.integer :imageable_id
      t.string  :imageable_type
      t.timestamps
    end
  end
end
```

can be simplified by reference

```ruby
class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.references :imageable, polymorphic: true
      t.timestamps
    end
  end
end
```
#### student and teacher many to many

```ruby
class Student < ActiveRecord::Base
  attr_accessible :name
  has_many :student_teacher_links
  has_many :teachers, through: :student_teacher_links
end

class Teacher < ActiveRecord::Base
  attr_accessible :name
  has_many :student_teacher_links
  has_many :students, through: :student_teacher_links
end

class StudentTeacherLink < ActiveRecord::Base
  belongs_to :student
  belongs_to :teacher
  # attr_accessible :title, :body
end
```

#### User self reference associations

```ruby
class User < ActiveRecord::Base
  attr_accessible :name

 has_many :friend_links 
 has_many :friends, through: :friend_links

 has_many :ofriend_links, foreign_key: :friend_id, class_name: :FriendLink
 has_many :ofriends, through: :ofriend_links,  source: :user

 def allfriends
   friends + ofriends
 end
end


class FriendLink < ActiveRecord::Base
  attr_accessible :friend_id, :user_id

  belongs_to :user
  belongs_to :friend, class_name: :User
end
```

#### User and student teacher

```ruby
class User < ActiveRecord::Base
  attr_accessible :name

  has_many :student_links, foreign_key: :student_id, class_name: :StudentTeacherLink
  has_many :students, through: :student_links
  has_many :teacher_links, foreign_key: :teacher_id, class_name: :StudentTeacherLink
  has_many :teachers, through: :teacher_links
end

class StudentTeacherLink < ActiveRecord::Base
  attr_accessible :student_id, :teacher_id
  belongs_to :teacher, foreign_key: :student_id, class_name: :User
  belongs_to :student, foreign_key: :teacher_id, class_name: :User
end
```


#### example of through with polymorphic

```ruby
class Article < ActiveRecord::Base
  has_many :attachable_entities, as: :entity
  has_many :attachables, through: :attachable_entities, source: :attachable, source_type: Image 
end

class AttachableEntity < ActiveRecord::Base
  belongs_to :entity, polymorphic: true
  belongs_to :attachable, polymorphic: true
end

class Image < ActiveRecord::Base
  has_many :attachable_entities, as: :attachable
  has_many :entities, through: :attachable_entities, source: :entity, source_type: Article 
end
```


#### the combatination validation

```ruby
class Person < ActiveRecord::Base
  validates_uniqueness_of :user_name, scope: :account_id
end
```
using scope will combinate the user_name and account table

```ruby
#Or even multiple scope parameters. For example, making sure that a teacher can only #be on the schedule once per semester for a particular class.

class TeacherSchedule < ActiveRecord::Base
  validates_uniqueness_of :teacher_id, scope: [:semester_id, :class_id]
end
#It is also possible to limit the uniqueness constraint to a set of records matching #certain conditions. In this example archived articles are not being taken into #consideration when validating uniqueness of the title attribute:

class Article < ActiveRecord::Base
  validates_uniqueness_of :title, conditions: -> { where.not(status: 'archived') }
end
```


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
