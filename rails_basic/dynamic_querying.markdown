




### Dynamic ActiveRecord querying


```ruby
class CreateGuitars < ActiveRecord::Migration
  def change
    create_table "guitars" do |t|
      t.string "type", :null => false               # Guitar, Banjo, Bass Guitar, Ukelele, etc
      t.string "make", :null => false               # Gibson, Fender, PRS, etc
      t.string "model", :null => false              # SG, Stratocaster, Flying-V, etc
      t.string "color"                              # Hot-rod Red, Lightning Blue
      t.integer "price", :null => false
      t.integer "year", :null => false
      t.boolean "used", :default => false
      t.timestamps
    end
  end
end
```
