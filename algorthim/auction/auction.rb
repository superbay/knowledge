module Auction
  class Item
    attr_accessor :name, :reserved_price, :status, :sold_price, :bid_list, :current_win
    def initializer(name, reserved_price)
      self.name = name
      self.reserved_price = reserved_price
      self.status = 'ready'
    end
  end

  class Auction
    attr_accessor :items
    def initializer(item)
      return 'sold item' if item.status == 'sold'
      self.items << item
    end

    def start_bid(item, bid)
      return 'fail bid' if !self.items.include?(item) || bid.price <= self.current_win.price
      item.current_win = bid
      item.bid_list << bid
      if bid.price > item.reserved_price
        item.status = 'sold'
        item.sold_price = bid.price
      end
    end
  end

  class Bid
    attr_accessor :bidder_name, :price
    def initializer(name, price)
      self.bidder_name = name
      self.price = price
    end
  end
end