## Ruby Circuit Breaker


![circuit_breaker](https://cloud.githubusercontent.com/assets/83296/18030833/38ac9d16-6c95-11e6-994d-7cff19815f8e.PNG)


### what's Circuit Breaker and why we need 


```ruby
client = Nip.new
loop do
  print "\n> "
    input = gets.chomp.downcase
  case input
  when /followers/
    ids = client.follower_ids
    ids.each do |id|
      puts id
    end
  when /timeline/
    ids = client.follower_ids
    ids.each do |id|
      status = client.status_for_id(id)
      puts "#{id}: #{status}"
    end
  when /quit/
    exit(0)
  else
    puts "I don't know that command"
  end
end
```

while triggering 

```ruby
> timeline
nip.rb:7:in `status_for_id': We are over-capacity, chill out! (RuntimeError)
	from nip.rb:26:in `block (2 levels) in <main>'
	from nip.rb:25:in `each'
	from nip.rb:25:in `block in <main>'
	from nip.rb:14:in `loop'
	from nip.rb:14:in `<main>'
```

### solution 1

```ruby

require "delegate"
class SafeNip < DelegateClass(Nip)
  def follower_ids
    super
  rescue => error
    warn "ERROR getting follower IDs: #{error}"
    []
  end
 
  def status_for_id(id)
    super
  rescue => error
    warn "ERROR getting status for id #{id}: #{error}"
    "<Status Unavailable>"
  end
end
 
client = SafeNip.new(Nip.new)
# ...

### THen
> timeline
ERROR getting status for id kitty574: We are over-capacity, chill out!
kitty574: <Status Unavailable>
ERROR getting status for id kitty709: We are over-capacity, chill out!
kitty709: <Status Unavailable>
ERROR getting status for id kitty385: We are over-capacity, chill out!
kitty385: <Status Unavailable>
ERROR getting status for id kitty161: We are over-capacity, chill out!
kitty161: <Status Unavailable>
ERROR getting status for id kitty254: We are over-capacity, chill out!
kitty254: <Status Unavailable>
...
```

For one thing, it’s cluttering up our logs with all the error messages. And for another, the last thing a web service that is over capacity wants is to receive hundreds of hits in a row. We are in danger of having our IP blocked by the site admins if we keep this up.

So what can we do? We want to be able to deal gracefully with a few exceptions, but we need to switch to a different strategy if we are getting lots of exceptions in a row.


```ruby
class CircuitBreaker
  class OpenError < StandardError
  end
 
  def initialize(threshold: 5)
    @state       = :closed
    @threshold   = threshold
    @error_count = 0
  end
 
  def monitor
    raise OpenError, "Circuit breaker is open" if @state == :open
    result = yield
    handle_success
    result
  rescue OpenError
    raise
  rescue => error
    handle_error(error)
    raise
  end
 
  def open?
    @state == :open
  end
 
  private
 
  def handle_success
    @error_count = 0
  end
 
  def handle_error(error)
    @error_count += 1
    warn "Failure count is now #{@error_count}"
    if @error_count >= @threshold
      @state = :open
      warn "Circuit breaker has tripped!"
    end
  end
end
```


```ruby
class NipCircuitBreaker < DelegateClass(Nip)
  def initialize(target, breaker: CircuitBreaker.new)
    @circuit_breaker = breaker
    super(target)
  end
 
  def follower_ids
    @circuit_breaker.monitor do
      super
    end
  end
 
  def status_for_id(id)
    @circuit_breaker.monitor do
      super
    end
  end
 
end
```


```ruby

> timeline
Failure count is now 1
ERROR getting status for id kitty225: We are over capacity, chill out!
kitty225: <Status Unavailable>
Failure count is now 2
ERROR getting status for id kitty401: We are over capacity, chill out!
kitty401: <Status Unavailable>
Failure count is now 3
ERROR getting status for id kitty406: We are over capacity, chill out!
kitty406: <Status Unavailable>
Failure count is now 4
ERROR getting status for id kitty152: We are over capacity, chill out!
kitty152: <Status Unavailable>
Failure count is now 5
Circuit breaker has tripped!
ERROR getting status for id kitty921: We are over capacity, chill out!
kitty921: <Status Unavailable>
ERROR getting status for id kitty283: Circuit breaker is open
kitty283: <Status Unavailable>
ERROR getting status for id kitty739: Circuit breaker is open
kitty739: <Status Unavailable>
...
```

### break

```ruby
ids = client.follower_ids
ids.each do |id|
  break if breaker.open?
  status = client.status_for_id(id)
  puts "#{id}: #{status}"
end

### Result
> timeline
Failure count is now 1
ERROR getting status for id kitty720: We are over capacity, chill out!
kitty720: <Status Unavailable>
Failure count is now 2
ERROR getting status for id kitty243: We are over capacity, chill out!
kitty243: <Status Unavailable>
Failure count is now 3
ERROR getting status for id kitty757: We are over capacity, chill out!
kitty757: <Status Unavailable>
Failure count is now 4
ERROR getting status for id kitty932: We are over capacity, chill out!
kitty932: <Status Unavailable>
Failure count is now 5
Circuit breaker has tripped!
ERROR getting status for id kitty131: We are over capacity, chill out!
kitty131: <Status Unavailable>
 
> timeline
ERROR getting follower IDs: Circuit breaker is open
```
