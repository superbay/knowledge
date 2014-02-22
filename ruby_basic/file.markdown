## realine


```ruby
f = File.read('public/file.csv').read
lines = f.each_line.map{|x|x}


lines = File.readlines('public/file.csv')
```


```ruby
File.open("my/file/path", "r").each_line do |line|
  puts line
end
```


#### Write file

```ruby
File.open(path, 'w') do |file|
  file.puts lines
end
```


### Yaml load

after ruby 2.0
```
require 'yaml'
thing = YAML.load_file('some.yml')
puts thing.inspect

#{"javascripts"=>[{"fo_global"=>["lazyload-min", "holla-min"]}]}
```
