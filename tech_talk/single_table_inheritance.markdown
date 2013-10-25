### What's STI


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

#### exception & Legacy database
Finally, legacy database constraints may require a different name in the database for the type column. In this case, you can set the new column name using the class setter method inheritance_column in the base class. For the Timesheet example, we could do the following:

```ruby
classTimesheet<ActiveRecord::Base
2 self.inheritance_column = 'object_type'
3 end
```

