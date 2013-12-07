1. Given an array of unsorted positive ints, write a function that finds runs of 3 consecutive numbers (ascending or descending) and returns the indices where such runs begin.  If no such runs are found, return null.

function findConsecutiveRuns(input:Array):Array
Example:  [1, 2, 3, 5, 10, 9, 8, 9, 10, 11, 7] would return [0, 4, 6, 7]


2. Write a backend library for auction house for their online auction system so it supports the following operations( assume that we have a in memory key-value store lib available)
Add an item that can be auctioned. An item has a name and reserved price
Start an auction on an item
Submit a bid to a normal auction, a bid has the bidder's number and a price, a new bid has to have a price higher than the current highest bid otherwise it's not allowed
Call the normal auction - bring it to an end. If the current highest bid is higher than the reserved price of the item, the auction is deemed as a success other wise it's marked as failure. The item sold should be no longer available for future auctions


3. deep_clone circle reference hash
example: 

```ruby
hash = {
  a: 2,
  b: {c: 8, d: hash},
  e: hash
}
```

4. dictionary find the shortest path

given certain dictionary which has relation between words, implement method to find the shortest path from two words

```ruby
# dog => cat, cat => bag, bag => jack
# then it's the shortest path 

```

