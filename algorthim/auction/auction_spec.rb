load 'auction.rb'
#include Auction
describe Auction do
  context 'new item' do
    it 'should create new item and add to autcion' do
      item = Auction::Item.new('moon', 99.99)
      item.status.should eq 'ready' 
      auction = Auction::Auction.new([item])
      auction.ready_items.should include item
    end
  end
end