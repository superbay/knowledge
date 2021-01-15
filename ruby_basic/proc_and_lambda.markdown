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

