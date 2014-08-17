




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

Solution 2

```ruby

filters = [:type, :make, :model, :color]
wheres = filters.map{|key| params.has_key?(key) ? {key => params[key]} : {} }
                .inject({}){|hash, injected| hash.merge!(injected)}

@guitars = Guitar.where(wheres).limit(25)
render :json => @guitars.as_json(:include => :merchants )


```


Solution 3


```ruby

    conditions = String.new
    wheres = Array.new

    if params.has_key?(:type)
      conditions << " AND " unless conditions.length == 0
      conditions << "type = ?"
      wheres << params[:type]
    end
    if params.has_key?(:make)
      conditions << " AND " unless conditions.length == 0
      conditions << "make = ?"
      wheres << params[:make]
    end
    if params.has_key?(:model)
      conditions << " AND " unless conditions.length == 0
      conditions << "model = ?"
      wheres << params[:model]
    end
    if params.has_key?(:color)
      conditions << " AND " unless conditions.length == 0
      conditions << "color = ?"
      wheres << params[:color]
    end
    if params.has_key?(:price)
      conditions << " AND " unless conditions.length == 0
      conditions << "price < ?"
      wheres << params[:price]
    end
    if params.has_key?(:city)
      conditions << " AND " unless conditions.length == 0
      conditions << "merchants.city = ?"
      wheres << params[:city]
    end

    wheres.insert(0, conditions)

    @guitars = Guitar.includes( [:merchants] ).where( wheres )
                     .order( "#{params[:sort] or 'price'} #{params[:order] or 'DESC'}" ).limit( 25 )

    render :json => @guitars.as_json(:include => :merchants )

```


Solution 4


```ruby


# Model
class Guitar < ActiveRecord::Base
  scope :by_type, lambda { |type|
    return scoped unless type.present?
    where(:type => type)
  }

  scope :by_color, lambda { |color|
    return scoped unless color.present?
    where(:color => color)
  }

  scope :by_make, lambda { |make|
    return scoped unless make.present?
    where(:make => make)
  }

  scope :by_model, lambda { |model|
    return scoped unless model.present?
    where(:model => model)
  }
  scope :by_price, lambda { |price|
    return scoped unless price.present?
    where("price < ?", price)
  }
  scope :by_city, lambda { |city|
    return scoped unless city.present?
    where("merchants.city = ?", city)
  }
end

# Controller
class GuitarsController < ApplicationController
  def index
    @guitars = Guitar.includes( [:merchants] )
                     .by_type( params[:type] ).by_color( params[:color] ).by_make( params[:make] )
                     .by_model( params[:model] ).by_price( params[:price] ).by_city( params[:city] )
                     .order( order ).limit( limit )

    render :json => @guitars.as_json(:include => :merchants )
  end
end

```


Solution 5


```ruby

# Model
class Guitar < ActiveRecord::Base

  def self.by_type(type)
    return scoped unless type.present?
    where(:type => type)
  end
  def self.by_color(color)
    return scoped unless color.present?
    where(:color => color)
  end
  def self.by_make(make)
    return scoped unless make.present?
    where(:make => make)
  end
  def self.by_model(model)
    return scoped unless model.present?
    where(:model => model)
  end
  def self.by_price(price)
    return scoped unless price.present?
    where("price < ?", price)
  end
  def self.by_city(city)
    return scoped unless city.present?
    where("merchants.city = ?", city)
  end

end

# Controller
class GuitarsController < ApplicationController
  def index
    @guitars = Guitar.includes( [:merchants] )
                     .by_type( params[:type] ).by_color( params[:color] ).by_make( params[:make] )
                     .by_model( params[:model] ).by_price( params[:price] ).by_city( params[:city] )
                     .order( order ).limit( limit )

    render :json => @guitars.as_json(:include => :merchants )
  end
end

```


