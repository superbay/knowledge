load 'auction.rb'
describe Auction do
  context 'new item' do
    it 'should create new item and add to auction' do
      item = Auction::Item.new('moon', 99.99)
      item.status.should eq 'ready' 
      auction = Auction::Auction.new([item])
      auction.ready_items.should include item
    end
  end

  context 'bid auction' do
    before :each do 
      @moon = Auction::Item.new('moon', 99.99)
      sun = Auction::Item.new('sun', 999.99)
      earth = Auction::Item.new('earth', 666.66)
      @auction = Auction::Auction.new([@moon, sun])
      bid1 = Auction::Bid.new('Ken', 66.66)
      @auction.start_bid(@moon, bid1)
    end

    it 'should has to have a price higher than the current highest bid' do
      bid2 = Auction::Bid.new('Ken', 33.33)
      @auction.start_bid(@moon, bid2).should eq 'fail bid'
      bid3 = Auction::Bid.new('Ken', 77.33)
      expect{@auction.start_bid(@moon, bid3)}.to change{@moon.bid_list.count}.by(1)
      expect(@moon.current_bid.price).to eq 77.33
    end
   
    it 'should close the auction for the item while bid price is highest' do 
      bid4 = Auction::Bid.new('Ken', 100)
      expect{@auction.start_bid(@moon, bid4)}.to change{@moon.bid_list.count}.by(1)
      expect(@moon.status).to eq 'sold'
    end

    it 'The item sold should be no longer available for future auctions' do
      bid4 = Auction::Bid.new('Ken', 100)
      expect{@auction.start_bid(@moon, bid4)}.to change{@moon.bid_list.count}.by(1)
      bid5 = Auction::Bid.new('Ken', 200)
      @auction.start_bid(@moon, bid5).should eq 'fail bid' 
    end

  end
end