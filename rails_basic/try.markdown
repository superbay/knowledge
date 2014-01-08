### understand try


First, Try is rails method, not ruby method

```ruby
1.9.2p320 :001 > nil.try(:abc)
 => nil
 
1.9.2p320 :003 > User.first.try(:abc)
  User Load (0.3ms)  SELECT `users`.* FROM `users` LIMIT 1
NoMethodError: undefined method `abc' for #<User:0x007fe14495c018>

```

So, Try only handle the case which is nil
