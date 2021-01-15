### basic usage and format

```ruby
times_two = ->(x) { x * 2 }

 times_two.call(10)
 => 20
```


#### Proc can accept arguments
```ruby
t = Proc.new{ |x, y| x * 2 + y.to_i }
 => #<Proc:0x0000000001c38b50@(irb):9> 
2.6.3 :010 > t.call(2)
 => 4  
```

#### lambda not

```ruby
 times_two = ->(x, y=1) { x * 2 + y }                                                                            
 => #<Proc:0x0000000001c51330@(irb):11 (lambda)> 
2.6.3 :012 > times_two.call(10)                                                                                              
 => 21 
2.6.3 :013 > times_two = ->(x, y) { x * 2 + y.to_i }                                                                         
 => #<Proc:0x0000000001c716d0@(irb):13 (lambda)> 
2.6.3 :014 > times_two.call(10)
Traceback (most recent call last):
        5: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/bin/irb:23:in `<main>'
        4: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/bin/irb:23:in `load'
        3: from /home/ec2-user/.rvm/rubies/ruby-2.6.3/lib/ruby/gems/2.6.0/gems/irb-1.0.0/exe/irb:11:in `<top (required)>'
        2: from (irb):14
        1: from (irb):13:in `block in irb_binding'
ArgumentError (wrong number of arguments (given 1, expected 2))

```


### different deal with return

```ruby
2.6.3 :038 > def call_1; puts 'b'; mp = -> () {return 2}; mp[]; puts 'a'; end;                                               
 => :call_1 
2.6.3 :039 > call_1
b
a
 => nil 
2.6.3 :040 > mp = -> (x) {puts x * 5; return 5; }
 => #<Proc:0x0000000001c81238@(irb):40 (lambda)> 
2.6.3 :041 > mp[]
2.6.3 :043 > mp[3]                                                                                                           
15
 => 5 
2.6.3 :044 > mp = -> (x) {puts x * 5; return 5; }                                                                            
 => #<Proc:0x00000000019c4900@(irb):44 (lambda)> 
2.6.3 :045 > mp[3]
15
 => 5 
```

#### full example

```ruby
2.6.5 :005 > def call_l; puts 'b'; mp = -> () {return 2}; puts mp[]; puts 'a'; end;                                                                                                              
 => :call_l 
2.6.5 :006 > call_l
b
2
a
 => nil 
2.6.5 :007 > def call_p; puts 'b'; mp = Proc.new {return 2}; puts mp[]; puts 'a'; end;                                                                                                           
 => :call_p 
2.6.5 :008 > call_p
b
 => 2 
 
 ```


###Organizing your code with procs

Procs are useful code organization tools. Let’s say that you want to calculate the running time for a few code snippets, in order to benchmark them. To do this elegantly, you want to be able to call a method and pass some code to it, and have the execution time returned.

Here’s how you can use procs to do just that:

```ruby
def time(a_proc)
  start = Time.now
  a_proc.call
  puts Time.now - start
end
 
time(Proc.new { code_here })
time(Proc.new { more_code_here })
```

The execution times of the code inside the procs will be neatly displayed as you run this code. Try it yourself, right now! You can use sleep(2), 1000.times { 5 + 5 }, or anything else you might want to speed test.

###Blocks!
In addition to method arguments, a method can also take a block. Passing a block is essentially the same as passing a proc, except that the syntax is different (and nicer), and you don’t have to type as much. Other than that, procs and blocks are essential the same thing: code that you can call later on.

```ruby
def time
  start = Time.now
  yield
  puts Time.now - start
end
 
time { code_here }
time { more_code_here }
```


###Passing arguments to procs and blocks
When you yield or call, you can pass arguments to the proc or block at the same time. A dumb example:

```ruby
def dumb_hello_world_test
  yield(5)
end

dumb_hello_world_test {|i| puts i * 2 }
# => 10

my_silly_proc = Proc.new {|name| puts name.upcase }
my_silly_proc.call("August Lilleaas")
# => "AUGUST LILLEAAS"
```

You have probably seen blocks taking arguments before: each, map and other enumerable methods does this.

```ruby
[1, 2, 3].map {|i| puts i * 2 }
# => 2
# => 4
# => 6

#That’s right: map takes a block. The block gets an argument: the number in the array. Now, for something hardcore. Let’s play with an implementation of Array#each.

class Array
  def each
    i = 0
    while(i < self.length) do
      yield(self[i])
      i += 1
    end
  end
end

my_array = ["a", "b", "c"]
my_array.each {|letter| puts letter }
# => "a"
# => "b"
# => "c"
```
We iterate the items in the array, and call the block — yield — for every item in the array. When we yield, we pass the current array iteration to the block.


### way to excute

```ruby
my_lambda = -> { puts "Lambda called" }
my_lambda.call
my_lambda.()
my_lambda[]
my_lambda.===
```

### Proc.new {} vs proc {}

From Metaprogamming Ruby Page 113.

In Ruby 1.8, Kernel#proc() is actually a synonym for Kernel#lambda(). Because of loud protest from programmers, Ruby 1.9 made proc() a synonym for Proc.new() instead.
