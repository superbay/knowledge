#### migration with references


```bash
$ rails generate model Product name:string description:text
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


#### support type

```bash
$ rails generate migration AddDetailsToProducts price:decimal{5,2} supplier:references{polymorphic}
```

```ruby
class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, precision: 5, scale: 2
    add_reference :products, :user, polymorphic: true, index: true
  end
end
```


```
add_column
add_index
add_reference
add_timestamps
create_table
create_join_table
drop_table (must supply a block)
drop_join_table (must supply a block)
remove_timestamps
rename_column
rename_index
remove_reference
rename_table
```

#### Reversible

```ruby
class ExampleMigration < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category
    end
 
    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE products
            ADD CONSTRAINT fk_products_categories
            FOREIGN KEY (category_id)
            REFERENCES categories(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE products
            DROP FOREIGN KEY fk_products_categories
        SQL
      end
    end
 
    add_column :users, :home_page_url, :string
    rename_column :users, :email, :email_address
  end
end
```
  



