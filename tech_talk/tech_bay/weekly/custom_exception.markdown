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

But we can change this with an extra leading argument. For instance, here we raise ArgumentError, which is a built-in exception type that Ruby uses when calling some methods with the wrong kinds of arguments.
 
```ruby
error = begin
          fail ArgumentError, "Something bad happened"
        rescue => error
          error
        end
 
error # => #<ArgumentError: Something bad happened>
```

### own exception classes

```ruby
class FurnaceLightingError
end
 
begin
  raise FurnaceLightingError
rescue => error
  error
end
 
error                           # => #<TypeError: exception class/object expected>


##Instead of our error being raised, we see a TypeError instead. This is because Ruby has a rule that only objects which inherit from the Exception base class can be raised as exceptions.

class FurnaceLightingError < Exception
end
```


```ruby

ObjectSpace.each_object(Class).select{|klass| klass.ancestors[1] == Exception}
# => [SystemStackError, NoMemoryError, SecurityError, ScriptError, StandardEr...
```


Instead, I normally inherit my custom error classes from StandardError. This is the class that the Ruby’s non-fatal exceptions generally inherit from.


```ruby
class FurnaceLightingError < StandardError
end
```


Once we start creating our own error classes, it’s easy to go nuts and make a custom exception classes for every possible error. But in practice I haven’t found this to be a helpful habit. In fact, I usually start with just a single error type for a given application or library.

Let’s say our Thermostat code lives inside a larger ClimateControl module. In this case, I would normally create a single custom exception class, called Error, inside that namespace.

```ruby
require "rspec/autorun"
 
module ClimateControl
 
  class Error < StandardError
  end
 
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
end
# >> .
# >>
# >> Finished in 0.00114 seconds (files took 0.08665 seconds to load)
# >> 1 example, 0 failures
# >>
```


I give it the generic-seeming name Error because, since it is inside a namespace, it is implicitly a ClimateControl::Error.

```ruby
module ClimateControl
  class Error
  end
end
 
ClimateControl::Error           # => ClimateControl::Error
```
With a custom error class in place, we can now raise it instead of a generic RuntimeError. And we can specify it as the type of error we expect to be raised when the furnace won’t turn on. Note that since the RSpec example is written inside the ClimateControl module, we don’t have to spell out the fully-qualified name of the error type.

```ruby
require "rspec/autorun"
 
module ClimateControl
 
  class Error < StandardError
  end
 
  class Thermostat
    def initialize(thermometer:,furnace:)
      @thermometer = thermometer
      @furnace     = furnace
    end
 
    def check_temperature
      temp = @thermometer.temp_f
      if temp <= 67
        @furnace.turn_onor fail Error, "Furnace could not be lit"
      end
    end
  end
 
  RSpec.describe Thermostat do
    # ...
 
    it "raises an exception when the furnace fails to light" do
      thermometer = double(temp_f: 67)
      furnace     = double(turn_on: false)
      thermostat  = Thermostat.new(thermometer: thermometer, furnace: furnace)
 
      expect { thermostat.check_temperature }.to raise_error(Error)
    end
 
  end
end
 
# >> .
# >>
# >> Finished in 0.00142 seconds (files took 0.13485 seconds to load)
# >> 1 example, 0 failures
# >>
```


### rspec test


```ruby

expect { thermostat.check_temperature }
  .to raise_error(Error, /furnace could not be lit/i)
  
begin
  # some code...
rescue ClimateControl::Error => error
  # ...
rescue => error # other kinds of error
  # ...
end
```
