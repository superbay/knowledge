## Active Record


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
