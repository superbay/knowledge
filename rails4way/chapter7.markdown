## Active Record Associations

#### select

```ruby
user.timesheets.select(:submitted).to_a
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
