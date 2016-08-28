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
