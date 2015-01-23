### how to rewrite attribute


```ruby
def name=(name)
  write_attribute(:name, name.capitalize)
end

def name
  read_attribute(:name).downcase  # No test for nil?
end

```
