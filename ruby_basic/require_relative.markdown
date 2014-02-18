### How require relative 


```ruby
require_relative
```

Before I made the jump to 1.9.2 I used the following for relative requires:


```ruby
require File.expand_path('../relative/path', __FILE__)

```
