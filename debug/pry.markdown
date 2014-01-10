## pry-debugger


how to use pry-debugger

```ruby
gem 'pry-debugger'
```


```ruby
#.pryrc
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'
```
