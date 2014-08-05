
### Searching serialized data, using active record



```ruby

serialize :mycode, Array


1.9.3p125 :026 > MyModel.find(104).mycode
  MyModel Load (0.6ms)  SELECT `mymodels`.* FROM `mymodels` WHERE `mymodels`.`id` = 104 LIMIT 1
 => [43565, 43402] 
1.9.3p125 :027 > MyModel.find_all_by_mycode("[43402]")
  MyModel Load (0.7ms)  SELECT `mymodels`.* FROM `mymodels` WHERE `mymodels`.`mycode` = '[43402]'
 => [] 
1.9.3p125 :028 > MyModel.find_all_by_mycode(43402)
  MyModel Load (1.2ms)  SELECT `mymodels`.* FROM `mymodels` WHERE `mymodels`.`mycode` = 43402
 => [] 
1.9.3p125 :029 > MyModel.find_all_by_mycode([43565, 43402])
  MyModel Load (1.1ms)  SELECT `mymodels`.* FROM `mymodels` WHERE `mymodels`.`mycode` IN (43565, 43402)
 => [] 
 
 ```
 
 
 ```ruby
 MyModel.all.select { |m| m.mycode.include? 43402 }
 
 MyModel.where("mycode = ?", [43565, 43402].to_yaml)
#=> [#<MyModel id:...]
 
 ```
