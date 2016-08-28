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
