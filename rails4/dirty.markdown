
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
