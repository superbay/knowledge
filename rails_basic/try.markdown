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


### Rails 4 the try behavior changed


```ruby
Loading development environment (Rails 4.0.0)                                                                                                                       
2.0.0p353 :001 > Version                                                                                                                                            
 => Version(id: integer, item_type: string, item_id: integer, event: string, whodunnit: string, object: text, created_at: datetime)                                 
2.0.0p353 :002 > Version.first                                                                                                                                      
  Version Load (0.5ms)  SELECT "versions".* FROM "versions" ORDER BY "versions"."id" ASC LIMIT 1                                                                    
 => nil                                                                                                                                                             
2.0.0p353 :003 > Version.first.try(:something)                                                                                                                      
  Version Load (0.4ms)  SELECT "versions".* FROM "versions" ORDER BY "versions"."id" ASC LIMIT 1                                                                    
 => nil                                                                                                                                                             
2.0.0p353 :004 > Version.first.something                                                                                                                            
  Version Load (0.4ms)  SELECT "versions".* FROM "versions" ORDER BY "versions"."id" ASC LIMIT 1                                                                    
NoMethodError: undefined method `something' for nil:NilClass                                                                                                        
        from (irb):4                                                                                                                                                
        from /home/action/.rvm/gems/ruby-2.0.0-p353@railscasts/gems/railties-4.0.0/lib/rails/commands/console.rb:90:in `start'                                      
        from /home/action/.rvm/gems/ruby-2.0.0-p353@railscasts/gems/railties-4.0.0/lib/rails/commands/console.rb:9:in `start'                                       
        from /home/action/.rvm/gems/ruby-2.0.0-p353@railscasts/gems/railties-4.0.0/lib/rails/commands.rb:64:in `<top (required)>'                                   
        from script/rails:6:in `require'                                                                                                                            
        from script/rails:6:in `<main>'                                                                                                                             
2.0.0p353 :005 > Version.first.try!(:something)                                                                                                                     
  Version Load (0.4ms)  SELECT "versions".* FROM "versions" ORDER BY "versions"."id" ASC LIMIT 1                                                                    
 => nil 
```

try! will behavior like rails3

```ruby
2.0.0p353 :002 > Version.create(item_type: 'Laptop', item_id: 1, event: 'nothing', object: 'what')                                                                  
   (0.2ms)  begin transaction                                                                                                                                       
  SQL (5.7ms)  INSERT INTO "versions" ("created_at", "event", "item_id", "item_type", "object") VALUES (?, ?, ?, ?, ?)  [["created_at", Wed, 08 Jan 2014 16:41:31 UT
C +00:00], ["event", "nothing"], ["item_id", 1], ["item_type", "Laptop"], ["object", "what"]]                                                                       
   (40.5ms)  commit transaction                                                                                                                                     
 => #<Version id: 1, item_type: "Laptop", item_id: 1, event: "nothing", whodunnit: nil, object: "what", created_at: "2014-01-08 16:41:31">                          
2.0.0p353 :003 > Version.first.try!(:something)                                                                                                                     
  Version Load (0.4ms)  SELECT "versions".* FROM "versions" ORDER BY "versions"."id" ASC LIMIT 1                                                                    
NoMethodError: undefined method `something' for #<Version:0x000000038bc9c0>  
```


[stackoverflow reference](http://stackoverflow.com/questions/7426808/rails-try-method-throwing-nomethoderror)
