### let


```ruby

subject(:hero) { Hero.first }
it "carries a sword" do
  expect(hero.equipment).to include "sword"
end

```
