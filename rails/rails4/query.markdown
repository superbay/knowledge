#### where not

Rails 4
```ruby
Foo.where.not(id: nil)
```

rails 3, still need arel_table
```ruby
Foo.includes(:bar).where(Bar.arel_table[:id].not_eq(nil))
```


```ruby
Post.includes(:comments).where(comments: { name: 'foo' })
#hash-based conditions
Post.includes(:comments).order('comments.name')
```
no conditions
The following cases do not require us to explicitly specify the reference:
```ruby
Post.includes(:comments).where('comments.name' => 'foo')
```



