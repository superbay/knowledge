## Custom Exception

```ruby

require "rspec/autorun"
 
class Thermostat
  def initialize(thermometer:,furnace:)
    @thermometer = thermometer
    @furnace     = furnace
  end
 
  def check_temperature
    temp = @thermometer.temp_f
    if temp <= 67
      @furnace.turn_onor fail "Furnace could not be lit"
    end
  end
end
 
RSpec.describe Thermostat do
  # ...
 
  it "raises an exception when the furnace fails to light" do
    thermometer = double(temp_f: 67)
    furnace     = double(turn_on: false)
    thermostat  = Thermostat.new(thermometer: thermometer, furnace: furnace)
 
    expect { thermostat.check_temperature }.to raise_error(/furnace could not be lit/i)
  end
 
end
 
# >> .
# >>
# >> Finished in 0.00114 seconds (files took 0.08665 seconds to load)
# >> 1 example, 0 failures
# >>

```

Why do we care at all about the kind of error that is raised? We care because ultimately, we might want to take action based on the error. Either a human being is going to read the message and do something as a result; or some other part of the program is going to take action when it sees this exception.

Let’s talk about the latter case, where the program acts based on an exception that is raised. Unlike RSpec matchers, Ruby does not have a simple, built-in way for exceptions to be matched based on their message. We can’t supply a regular expression to a Ruby rescue statement.



```ruby
rescue /furnace could not be lit/i
  # ...
end
#||
#\/
error = begin
          fail "Something bad happened"
        rescue => error
          error
        end
 
error # => #<RuntimeError: Something bad happened>
```


 
```
