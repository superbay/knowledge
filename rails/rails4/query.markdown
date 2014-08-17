#### where not


```ruby
Foo.where.not(id: nil)
```

rails 3, still need arel_table
```ruby
Foo.includes(:bar).where(Bar.arel_table[:id].not_eq(nil))
```



