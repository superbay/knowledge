## Single Table Inheritance(STI)


#### What's STI


official explain:
[Single table inheritance](http://api.rubyonrails.org/classes/ActiveRecord/Base.html)

Active Record allows inheritance by storing the name of the class in a column that by default is named “type” (can be changed by overwriting Base.inheritance_column). This means that an inheritance looking like this:
```ruby
class Company < ActiveRecord::Base; end
class Firm < Company; end
class Client < Company; end
class PriorityClient < Client; end
```
When you do Firm.create(name: "37signals"), this record will be saved in the companies table with type = “Firm”. You can then fetch this row again using Company.where(name: '37signals').first and it will return a Firm object.


#### Example


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

That latest change is a clear violation of the open-closed principle,5 which urges you to write code that is open for extension, but closed for modification. We know that we violated the principle, because we were forced to change the billable_hours_outstanding method to accommodate the new Timesheet status. Though it may not seem like a large problem in our simple example, consider the amount of conditional code that will end up in the Timesheet class once we start having to implement functionality such as paid_hours and unsubmitted_hours.
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

#### Real Case

origin desgin

```ruby

class Article
  #attr_accessible: :type
  as_enum :type, Types, :column => 'type_enum', :whiny => false

  Types = {
    :story        => 1,
    :column       => 2,
    :interview    => 3,
    :compound_doc => 4,
    :review       => 5,
    :graphic      => 6,
    :blog         => 7,
    :slideshow    => 8,
    :photo_essay  => 9
  }
end  
```

#### exception & Legacy database
Finally, legacy database constraints may require a different name in the database for the type column. In this case, you can set the new column name using the class setter method inheritance_column in the base class. For the Timesheet example, we could do the following:

```ruby
classTimesheet<ActiveRecord::Base
  self.inheritance_column = 'object_type'
end
```

