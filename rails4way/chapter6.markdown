## Active Record Migrations

#### belongs_to vs references

```ruby

create_table :accounts do
  t.belongs_to( :person )
end

create_table :comments do
  t.references( :commentable, polymorphic: true)
end

```

