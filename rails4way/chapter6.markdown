## Active Record Migrations

#### belongs_to vs references

```ruby

create_table :accounts do
  t.belongs_to( :person, index: true )
end
# the index option will create a corresponding index
create_table :comments do
  t.references( :commentable, polymorphic: true)
end

```

#### remove_collumn will behavior same

```ruby
t.remove_belongs_to(:person)
t.remove_references(:commentable,polymorphic:true)
```
#### data attributes mapping

![screen shot 2013-10-13 at 12 20 37 pm](https://f.cloud.github.com/assets/83296/1322304/772a6f26-3423-11e3-87bd-87ae758a6d4c.png)


