


https://github.com/eventmachine/eventmachine


https://github.com/RolifyCommunity/rolify


https://github.com/aasm/aasm



```ruby
require 'amqp'
module HiringThingEM
  def self.start
    if defined?(PhusionPassenger)
      PhusionPassenger.on_event(:starting_worker_process) do |forked|
      # for passenger, we need to avoid orphaned threads
        if forked && EM.reactor_running?
          EM.stop
        end
        Thread.new {
          EM.run do
             AMQP.channel ||= AMQP::Channel.new(AMQP.connect(:host=> Q_SERVER, :user=> Q_USER, :pass => Q_PASS, :vhost => Q_VHOST ))
          end
        }
        die_gracefully_on_signal
      end
    else
      # faciliates debugging
      Thread.abort_on_exception = true
      # just spawn a thread and start it up
        Thread.new {
          EM.run do
             AMQP.channel ||= AMQP::Channel.new(AMQP.connect(:host=> Q_SERVER, :user=> Q_USER, :pass => Q_PASS, :vhost => Q_VHOST ))
          end
        } unless defined?(Thin)
        # Thin is built on EventMachine, doesn't need this thread
    end
  end

  def self.die_gracefully_on_signal
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end
end

HiringThingEM.start

```
