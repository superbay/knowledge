#### migration with references


```bash
rails generate model Product name:string description:text
$ rails generate migration AddUserRefToProducts user:references
```

```ruby
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
 
      t.timestamps
    end
  end
end


class AddUserRefToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :user, index: true
  end
end


```
