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

Although scan does make little sense for this. It does still do the job, you just need to flatten the returned Array first.
```ruby
one, two, three = string.scan(/(^.*)(:)(.*)/i).flatten
```
