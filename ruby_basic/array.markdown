

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
