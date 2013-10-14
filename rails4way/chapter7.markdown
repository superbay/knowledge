## Active Record Associations

#### select

```ruby
user.timesheets.select(:submitted).to_a
Client.select(:id).map { |c| c.id }
# or
Client.select(:id).map(&:id)
# or
Client.select(:id, :name).map { |c| [c.id, c.name] }
```

#### relation build or create
```ruby
user.timesheets.build(attributes)
user.timesheets.new(attributes)#sameascallingbuild
```

#### first with number

```ruby
c.billing_codes.first(2)
```
