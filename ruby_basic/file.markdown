## realine


```ruby
f = File.read('public/file.csv').read
lines = f.each_line.map{|x|x}


lines = File.readlines('public/file.csv')
```
