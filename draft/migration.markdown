




#### migration with rake task invoke

```ruby
def up
  Rake::Task['your_task'].invoke
end

```



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


For instance, running:

```
$ rails generate migration AddDetailsToProducts 'price:decimal{5,2}' supplier:references{polymorphic}
```

will produce a migration that looks like this

```ruby
class AddDetailsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :decimal, precision: 5, scale: 2
    add_reference :products, :supplier, polymorphic: true, index: true
  end
end
```


#### rails run specific migration

```ruby
ails console
>> require "db/migrate/20090408054532_add_foos.rb"
>> AddFoos.up

script/runner 'require("db/migrate/20090408054532_add_foos.rb").first.constantize.up'
```

An alternative way (without IRB) which relies on the fact that require returns an array of class names:


```ruby
class AddPartNumberToProducts < ActiveRecord::Migration
  def change
    add_column :products, :part_number, :string
  end
end
#You can create an instance of the migration and run migrate(:up) or migrate(:down) on an instance, like this:

$ rails console
>> require "db/migrate/20090408054532_add_part_number_to_products.rb"
>> AddPartNumberToProducts.new.migrate(:down)
```


If you want to run a [specific migration](http://guides.rubyonrails.org/migrations.html#running-specific-migrations), do

```ruby
$ rake db:migrate:up VERSION=20080906120000
```

If you want to run migrations [multiple times](http://guides.rubyonrails.org/migrations.html#rolling-back), do


$ # use the STEP parameter if you need to go more than one version back
```ruby
$ rake db:migrate:redo STEP=3
```
If you want to run a single migration multiple times, do

$ # this is super usefull
```ruby
$ rake db:migrate:redo VERSION=20080906120000
```

#### one more reference example

```ruby

class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
    end

    create_table :taggings do |t|
      t.references :tag

      # You should make sure that the column created is
      # long enough to store the required class names.
      t.references :taggable, :polymorphic => true
      t.references :tagger, :polymorphic => true

      # Limit is created to prevent MySQL error on index
      # length for MyISAM table type: http://bit.ly/vgW2Ql
      t.string :context, :limit => 128

      t.datetime :created_at
    end

    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type, :context]
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end
end
```

also old rails 3 way used belongs_to

```ruby
class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, polymorphic: true

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
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


### change attribute to default 

```ruby
change_column :profiles, :show_attribute, :boolean, default: true
add_column :profiles, :show_attribute, :boolean, default: true
```
  



