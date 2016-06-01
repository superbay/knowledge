#### Ruby实用技巧 之 Stay Positive 

coding skill

```ruby
def average(collection)
  if collection.length.zero?
    nil
  else
    collection.inject(0.0, :+) / collection.length
  end
end
```

This method calculates the average of a collection of numbers.

```ruby
require "./average"

average([2, 4, 6, 8]) # => 5.0
```

…unless the collection is empty, in which case it returns nil.

```ruby
require "./average"

average([]) # => nil
```

This special-case return value for empty collections avoids a divide-by-zero error.

Here's how the method checks for an empty collection.

```ruby
if collection.length.zero?
  nil
else
  # ...
end
```

It asks the collection's length if it is zero. Checking the value of the length attribute echoes the fact that the length attribute is then used a few lines lower down.


`collection.inject(0.0, :+) / collection.length`

And asking the value if it is zero makes it very clear that it's a divide-by-zero situation that we're looking out for.

`collection.length.zero?`
That said, we could get the same information with one fewer method calls, by directly asking the collection if it is empty.

`collection.empty?`
Even after this change, there's still a pattern in this method which I usually try to avoid. This code prioritizes the edge-case. The first half of the method is concerned with dealing with the possibility of empty inputs. It's only after getting all that out of the way that we move on to the real "meat" of the method.

One alternative would be to move the empty-check into a guard clause, with an early return.

```ruby
def average(collection)
  return nil if collection.empty?
  collection.inject(0.0, :+) / collection.length
end
```

This still puts the edge case first, but at least this version gets it out of the way more quickly, and doesn't stuff the interesting bits into an else clause.

Another possiblity it to put the happy path first, and the edge case later. To do this, we have to take the original if/else statement and invert the condition.

```ruby
def average(collection)
  if !collection.empty?
    collection.inject(0.0, :+) / collection.length
  else
    nil
  end
end
```

I like that this defers the empty case till after the happy path. What I don't like about it is the negation. Every time some logic is negated, it adds a little extra mental overhead to keep track of.

So how do we ask the same question in a positive sense instead of a negative sense? You might know the answer already. Or, you might already know the method to use, but not realize it yet.

You may be aware of the #any? predicate on Ruby enumerable objects. With #any?, we can ask if there are any elements which have a particular property.

For instance, we can ask if there are any even numbers in a collection.

```ruby
[1, 3, 5, 8, 9].any?{|n| n.even?}
# => true
#Or if there are any three-letter words.

["apple", "banana", "strawberry"].any?{|n| n.length == 3}
# => false
```

What you might not know is that #any? can be sent without a block. In this case, it checks to see if the collection has any elements at all.

```ruby
[].any?                         # => false
["apple"].any?                  # => true
```

And there we have the answer to our question.

In order to keep our conditional logic positive, we can use the #any? predicate to check if the collection has anything in it.

```ruby
def average(collection)
  if collection.any?
    collection.inject(0.0, :+) / collection.length
  else
    nil
  end
end
```

This version puts the interesting and hopefully typical case first. It reads well too: "if there's anything in the collection, then perform an average reduction on it".

Incidentally, we don't actually need the else clause anymore.

```ruby
def average(collection)
  if collection.any?
    collection.inject(0.0, :+) / collection.length
  end
end
```

As you can see when we try it out, this code gives us the exact same behavior as before.

```ruby
require "./average3"
average([2, 4, 6, 8])           # => 5.0
average([])                     # => nil
```

This works because in Ruby, when an if statement's condition is not satisfied and it has no else clause, the default result value of the expression is nil.

```ruby
if 2 == 3
  "nope"
end
# => nil
```
So there you have it. By striving to put the happy path first, and to avoid negative logic, we've both shortened and simplified this method. Staying positive doesn't just improve our lives, it improves our code as well! Happy hacking!

