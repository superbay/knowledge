## Active Record

#### Where

```ruby
Message.where("subject LIKE: foo OR body LIKE :foo", foo:'%woah%')
```
where and like with prarameter


#### StaleObjectError

```ruby
def update
  timesheet = Timesheet.find(params[:id]) timesheet.update(params[:timesheet])
  # redirect somewhere
rescue ActiveRecord::StaleObjectError
  flash[:error] = "Timesheet was modified while you were editing it." 
  redirect_to [:edit, timesheet]
end
```

#### Readonly Attributes

```ruby
class Customer < ActiveRecord::Base
  attr_readonly :social_security_number
end
```


#### updating by condition

```ruby
Project.update_all({manager:'RonCampbell'}, technology: 'Rails')
Project.update_all("cost=cost*3", "lower(technology) LIKE '%microsoft%'")
```

#### instance attributes

```ruby
>>  first_client.attributes 
=> {"name" => "PaperJamPrinters", "code" => "PJP","id" => 1}
```

#### new record instance

```ruby
c = Client.new
c.new_record?
c.persisted?
```

#### default attribute value

some trick to set default value by read and write

```ruby
def preferences
  read_attribute(:preferences) || write_attribute(:preferences, {})
end
```

```ruby
class Specification < ActiveRecord::Base
  def tolerance
    self[:tolerance] || 'n/a'
  end
end

class SillyFortuneCookie < ActiveRecord::Base
  def message=(txt)
    self[:message] = txt + ' in bed' 
  end
end
```

#### Set name manually

```ruby
class Client < ActiveRecord::Base
  self.table_name = "CLIENT"
  self.primary_key = "CLIENT_ID"
end
```

#### Serialized Attributes

```ruby
class User < ActiveRecord::Base
  serialize :preferences, Hash
end
```

### migration

```ruby
add_column :users, :preferences, :text, default:"---{}"
```

```ruby
#fall back default serialized attributes
def preferences
  read_attribute(:preferences) || write_attribute(:preferences, {})
end
```

```ruby
class User < ActiveRecord::Base
  store :preferences
end
```



Enter text in [Markdown](http://daringfireball.net/projects/markdown/). Use the toolbar above, or click the **?** button for formatting help.
