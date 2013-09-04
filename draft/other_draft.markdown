### how to redirect path to public static file

```ruby
match '/foo', :to => redirect('/foo.html')
```
### scaffold with relation

```ruby
rails g resource activity user:belongs_to action trackable:belongs_to trackable_type
```
