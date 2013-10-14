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

#### pluck

```ruby
Client.where(active: true).pluck(:id)
# SELECT id FROM clients WHERE active = 1
# => [1, 2, 3]
 
Client.distinct.pluck(:role)
# SELECT DISTINCT role FROM clients
# => ['admin', 'member', 'guest']
 
Client.pluck(:id, :name)
# SELECT clients.id, clients.name FROM clients
# => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]
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
