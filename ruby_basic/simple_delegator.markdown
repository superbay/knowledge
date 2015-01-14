```ruby
require 'delegate'


class TicketSeller
  def sellTicket()
    return 'Here is a ticket'
  end
end


class NoTicketSeller
  def sellTicket()
    "Sorry-come back tomorrow"
   end
end


class TicketOffice < SimpleDelegator
  def initialize
    @seller = TicketSeller.new
    @noseller = NoTicketSeller.new
    super(@seller)
  end
  def allowSales(allow = true)
    __setobj__(allow ? @seller : @noseller)
    allow
  end
end

to = TicketOffice.new
to.sellTicket   »   "Here is a ticket"
to.allowSales(false)    »   false
to.sellTicket   »   "Sorry-come back tomorrow"
to.allowSales(true)     »   true
to.sellTicket   »   "Here is a ticket"
```
