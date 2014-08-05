

```ruby




['test', 'is'].count{ |s| /\b#{s}\b/ =~ 'This is a test string' }


```




```ruby
('This is a test string'.scan(/\w+/).map(&:downcase) & ['test', 'is']).length
```
