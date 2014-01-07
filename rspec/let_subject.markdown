### subject

If you have several tests related to the same subject use subject{} to DRY them up. 


```ruby

subject(:hero) { Hero.first }
it "carries a sword" do
  expect(hero.equipment).to include "sword"
end

```
