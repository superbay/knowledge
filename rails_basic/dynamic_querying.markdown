




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


class CreateMerchants < ActiveRecord::Migration
  def change
    create_table "merchants" do |t|
      t.string "name", :null => false
      t.string "city", :null => false
      t.string "state"
      t.string "email"
      t.string "phone"
    end
  end
end
```

Say you need a query



```ruby
#solution1


@guitars = Guitar.limit(25).includes( [:merchants] ).order( "#{params[:order] || 'price'} #{params[:sort] || 'DESC'}" )

@guitars = @guitars.where('type', params[:type]) if params[:type]
@guitars = @guitars.where('make', params[:make]) if params[:make]
@guitars = @guitars.where('model', params[:model]) if params[:model]
@guitars = @guitars.where('color', params[:color]) if params[:color]
@guitars = @guitars.where('price < ?', params[:price]) if params[:price]
@guitars = @guitars.where('merchants.city', params[:city]) if params[:city]

render :json => @guitars.as_json(:include => :merchants )


```

