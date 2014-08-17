
http://api.rubyonrails.org/classes/ActiveModel/Dirty.html


### ActiveModel::Dirty



```ruby
person.name = 'Bill'
person.name_changed?  # => false
person.name_change    # => nil
Which attributes have changed?

person.name = 'Bob'
person.changed        # => ["name"]
person.changes        # => {"name" => ["Bill", "Bob"]}
```

While you create a record, it changed? or not?

That depends on the default value

```ruby

add_column :user, :name, :string, default: 'ken'
ken = Person.create(name: 'ken')

class User < ActiveRecord::Base
  before_save do |user|
    puts user.changes
  end
end

```


### before_save loop


```ruby

before_save do
  self.update(username: self.username.downcase)
end


#should be 
before_save do
  self.username = self.username.downcase
end


```


or


```ruby


class User < ActiveRecord::Base
  def username=(val)
    write_attribute(:username, val.downcase)
  end
end


before_save { |user| user.username = user.username.downcase }

```




```ruby


person = Person.find_by_name('Uncle Bob')
person.changed?       # => false

person.name = 'Bob'
person.changed?       # => true
person.name_changed?  # => true
person.name_was       # => 'Uncle Bob'
person.name_change    # => ['Uncle Bob', 'Bob']

```
