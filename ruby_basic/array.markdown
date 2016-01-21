


```ruby
list.group_by{|x| x.created_at.strftime("%Y-%m-%d")} 
```



The method should return the creation date, possibly as string.

```ruby
def group_by_criteria
  created_at.to_date.to_s(:db)
end
```

Then, group by that method.

```ruby
list.group_by(&:group_by_criteria).map {|k,v| [k, v.length]}.sort
```



```ruby




['test', 'is'].count{ |s| /\b#{s}\b/ =~ 'This is a test string' }


```




```ruby
('This is a test string'.scan(/\w+/).map(&:downcase) & ['test', 'is']).length
```



```ruby

# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"

```

#### slice_before

```ruby
# iterate over ChangeLog entries.
open("ChangeLog") { |f|
  f.slice_before(/\A\S/).each { |e| pp e }
}

# same as above.  block is used instead of pattern argument.
open("ChangeLog") { |f|
  f.slice_before { |line| /\A\S/ === line }.each { |e| pp e }
}
```

#### flat_map

```ruby

[1, 2, 3, 4].flat_map { |e| [e, -e] } #=> [1, -1, 2, -2, 3, -3, 4, -4]
[[1, 2], [3, 4]].flat_map { |e| e + [100] } #=> [1, 2, 100, 3, 4, 100]

```


### detect


```ruby

(1..10).detect  { |i| i % 5 == 0 and i % 7 == 0 }   #=> nil
(1..100).detect { |i| i % 5 == 0 and i % 7 == 0 }   #=> 35

```


### drop & drop_while


```ruby
a = [1, 2, 3, 4, 5, 0]
a.drop_while { |i| i < 3 }   #=> [3, 4, 5, 0]

```


[references](http://ruby-doc.org/core-2.1.2/Enumerable.html#method-i-collect)
