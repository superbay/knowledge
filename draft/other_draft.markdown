### how to redirect path to public static file

```ruby
match '/foo', :to => redirect('/foo.html')
```
### scaffold with relation

```ruby
rails g resource activity user:belongs_to action trackable:belongs_to trackable_type
```

### brew service 

```
brew services list

```

   cleanup Get rid of stale services and unused plists
   list    List all services managed by `brew services`
   restart Gracefully restart selected service
   start   Start selected service
   stop    Stop selected service
