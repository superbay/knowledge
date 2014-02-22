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
```ruby
require 'yaml'
thing = YAML.load_file('some.yml')
puts thing.inspect

#{"javascripts"=>[{"fo_global"=>["lazyload-min", "holla-min"]}]}
```


```ruby


cnf = YAML::load_file(File.join(File.dirname(File.expand_path(__FILE__)), 'config.yml')
#EDIT:

#Since Ruby 2.0 you can simplify that and use:

nf = YAML::load_file(File.join(__dir__, 'config.yml'))

```



