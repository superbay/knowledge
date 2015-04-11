## Active Record

#### Connection with all the tables

```ruby
ActiveRecord::Base.connection.tables
```

#### excute mysql query directly

```ruby
ActiveRecord::Base.connection.execute("showtables").values
```

#### ActiveRecord::Store

```ruby
class User < ActiveRecord::Base
  store :settings, accessors: [ :color, :homepage ], coder: JSON
end

u = User.new(color: 'black', homepage: '37signals.com')
u.color                          # Accessor stored attribute
u.settings[:country] = 'Denmark' # Any attribute, even if not specified with an accessor

# There is no difference between strings and symbols for accessing custom attributes
u.settings[:country]  # => 'Denmark'
u.settings['country'] # => 'Denmark'

# Add additional accessors to an existing store through store_accessor
class SuperUser < User
  store_accessor :settings, :privileges, :servants
end
```

```ruby
classUser < ActiveRecord::Base
  store :preferences
end
```

#### Establish_connection

```ruby
class LegacyProjectBase < ActiveRecord::Base 
  establish_connection :legacy_database 
  #establish_connection adapter: 'sqlite3', database: ':memory:'
  self.abstract_class = true
end
```

#### Enhanced Eager and Lazy Loading

```ruby
Client.eager_load( users: [:avatar, { timesheets: :billable_weeks }])
Client.preload( users: [:avatar, { timesheets: :billable_weeks }])
```

```ruby
Client.includes(users: [:avatar, { timesheets: :billable_weeks }] )
# clients has_many :users
# User has_many :avatar
# User has_many :timesheets
# Timesheet has_many billable_weeks

Post.includes(:authors).where("authors.name" => "alice").first
Author.joins(:articles).where(articles: { author: author })
Article.includes(:comments).where(comments: { visible: true })
Article.includes(:comments).where("articles.published_at <= ? and comments.created_at >= ?", Time.now, Time.now - 1.month)
```
So, same level will be `Array`, lower one level will be `Hash`

```ruby
clients = Client.includes(users: [:avatar])
```

#### Eager loading eliminate 'N+1'

```ruby
users = User.where(login: "mack").includes(:billable_weeks)
users.first.billable_weeks.each{ |week| puts week}
```

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
