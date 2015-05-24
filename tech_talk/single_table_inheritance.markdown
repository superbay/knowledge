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


###What is Single Table Inheritance ?

Single Table Inheritance is, as the name suggests it, a way to add inheritance to your models. STI lets you save different models inheriting from the same model inside a single table.

For example, let’s say you have an employee model. The employees can be of two types : manager or developer. They pretty much share the same attributes and columns. However, their behavior should be different. Creating two tables having the exact same fields would be bad.

But here comes STI ! With STI, you can just keep your employee model and simply subclass it with your two types of employee. The only thing to do at the database level is to add a type column to the employees table that ActiveRecord will automatically use to identify the submodel. If you want to know more about STI and see a real example, keep reading !

With great power comes great responsibility

STI should be used if your submodels will share the same attributes but need different behavior. If you plan to add 10 columns only used by one submodel, using different tables might be a better solution.

###Creating the rails app

Time to create our rails app. If you already have a running app, jump to the next part. Else run the following commands.

Generate a rails app without tests and start the server

`rails new sti --no-test-framework`     
Generating the models and migrations

Now, we are going to generate our models and the related migrations.

Generate the Tribe model

`rails g model tribe name:string`

Generate the Animal model

rails g model animal name:string age:integer race:string
The race column is going to be used by Active Record to save the submodel name. By default, AR will search for a column named type but you can use anything as long as you tell AR about it.

Then you can either add the column tribe_id to the Animal migration file or create a new migration :

```ruby
class AddTribeIdToAnimal < ActiveRecord::Migration
  def change
    add_column :animals, :tribe_id, :integer
  end
end
```

Run the migrations

`rake db:migrate`

Our models are still empty, we should give them some life !

```ruby
# app/models/tribe.rb
class Tribe < ActiveRecord::Base 
    has_many :animals 
end

# app/models/animal.rb
class Animal < ActiveRecord::Base 
    belongs_to :tribe 
    self.inheritance_column = :race 

    # We will need a way to know which animals
    # will subclass the Animal model
    def self.races
      %w(Lion WildBoar Meerkat)
    end

end

class Lion < Animal; end 
class Meerkat < Animal; end 
class WildBoar < Animal; end
```

Nothing complicated here. We setup the relation between the tribe and the animals and create three empty submodels. Note that self.inheritance_column = :race is used to specify the column for STI and is not necessary if you are using the default column type.

If you want to disable Single Table Inheritance or use the type column for something else, you can use 

`self.inheritance_column = :fake_column.`


### Rails Auto-loading

Fire up a console and test that you can create each of the above models. You will see a NameError: uninitialized constant if you call a sub model (like Lion) before making a call to the parent model (Animal). This is due to Rails auto-loading system. To load a model, Rails is looking for a file called model_name.rb inside the app/models folder. There are a few solutions to fix this but we will use the simpliest one : just split each model declaration in its own file.

```ruby
# app/models/lion.rb 
class Lion < Animal; end

# app/models/meerkat.rb
class Meerkat < Animal; end

# app/models/wild_boar.rb 
class WildBoar < Animal; end
```

You can test again and everything will work just fine ! If you want to know about the other solutions, check this article.

###STI Tips

The basic setup is now completed. Here are some tips that can be useful with Single Table Inheritance.

Add scopes to the parent models for each child model

```ruby
scope :lions, -> { where(race: 'Lion') } 
scope :meerkats, -> { where(race: 'Meerkat') } 
scope :wild_boars, -> { where(race: 'WildBoar') }
```

Add delegates in the Tribe model

```
delegate :lions, :meerkats, :wild_boars, to: :animals
```
These are not mandatory but make the navigation between models easier.

### Fill the database

Before proceding to the next part, we are going to create some objects in the database and play with our models. For now, we will use the console rails c. Thanks to STI, we can now use the models Lion, WildBoar and Meerkar to create the corresponding animal. The column race will be automatically filled by Active Record.

###Create a tribe

```
tribe = Tribe.create(name: 'LionTribe')
Create some animals and add them to the tribe

tribe.animals << Lion.new(name: "Simba", age: 10) 
tribe.animals << WildBoar.new(name: "Pumba", age: 30) 
tribe.animals << Meerkat.new(name: "Timon", age: 30)
```

Note that you can use any of the following methods if you added the two tips about scopes and delegates :

```
tribe.wild_boars, tribe.lions, tribe.meerkats, tribe.animals 
Animal.lions, Animal.meerkats, Animal.wild_boars 
Animal.all, Lion.all, Meerkat.all, WildBoar.all
```

Our different animals (Simba, Pumba and Timon) all live in the table animals but are independant models. Now, we can give them some specific behavior, like talking (more like singing!).


```ruby
#app/models/animal.rb
def talk 
    raise 'Abstract Method' 
end

#app/models/meerkat.rb 
def talk 
    "Hakuna Matata, what a wonderful phrase !" 
end

#app/models/wild_boar.rb 
def talk 
    "Hakuna Matata! Ain't no passing craze" 
end

#app/models/lion.rb 
def talk 
    "It means no worries for the rest of your days" 
end
```
We also defined the talk method on animal as an “abstract method” (Since ruby doesn’t have abstract methods, we simply raise an exception if the model is called from Animal or from a submodel which doesn’t defines it). Indeed, we don’t know what a random animal have to sing !

Source Code

The code is available on Github.
https://github.com/T-Dnzt/sti-with-rails4

### Warm up

Just play around with your new STI models and see everything you can do. As you can see, it can be pretty useful. In the second part, we will see how we can present our inherited models to the world through a single controller and how to configure the routes to do so.

[next part](http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-2/)
[third part](http://samurails.com/tutorial/single-table-inheritance-with-rails-4-part-3/)
