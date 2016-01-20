### Regular Expression


group match




You don't want scan for this, as it makes little sense. You can use String#match which will return a MatchData object, you can then call #captures to return an Array of captures. Something like this:

```
#!/usr/bin/env ruby

string = "RyanOnRails: This is a test"
one, two, three = string.match(/(^.*)(:)(.*)/i).captures

p one   #=> "RyanOnRails"
p two   #=> ":"
p three #=> " This is a test"
```

Be aware that if no match is found, String#match will return nil, so something like this might work better:

```ruby
if match = string.match(/(^.*)(:)(.*)/i)
  one, two, three = match.captures
end
```



```ruby
if ryan_string =~ /(^.*)(:)(.*)/i
   first = $1
   third = $3
end
```

Although scan does make little sense for this. It does still do the job, you just need to flatten the returned Array first.
```ruby
one, two, three = string.scan(/(^.*)(:)(.*)/i).flatten
```





scan() will find all non-overlapping matches of the regex in your string, so instead of returning an array of your groups like you seem to be expecting, it is returning an array of arrays.

You are probably better off using match(), and then getting the array of captures using MatchData#captures:

```ruby
g1, g2, g3 = ryan_string.match(/(^.*)(:)(.*)/i).captures
```

However you could also do this with scan() if you wanted to:

```ruby
g1, g2, g3 = ryan_string.scan(/(^.*)(:)(.*)/i)[0]
```
