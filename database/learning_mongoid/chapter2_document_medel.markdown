#### Field aliases

```ruby
class Book
  include Mongoid::Document

  field :t, as: :title, type: String
end

```


better way to create alias and index

```ruby
class Contact
  include Mongoid::Document

  field :ln, as: :last_name, type: String
  field :fn, as: :first_name, type: String
  field :mn, as: :middle_name, type: String
  field :t, as: :title, type: String
  field :e, as: :employer, type: String
  field :on, as: :org_name, type: String
  field :o, as: :occupation, type: String
  field :pr, as: :prefix, type: String
  field :su, as: :suffix, type: String
  field :te, as: :telephone, type: String
  field :st1, as: :street_1, type: String
  field :st2, as: :street_2, type: String
  field :c, as: :city, type: String
  field :s, as: :state, type: String
  field :z, as: :zip_code, type: String

  index({ last_name: 1, last_name: 1, first_name: 1,
          middle_name: 1, title: 1, employer: 1, 
          org_name: 1, occupation: 1, prefix: 1,
          suffix: 1, telephone: 1, street_1: 1, 
          street_2: 1, city: 1, state: 1, zip_code: 1})
end
 
```

excute the index

```
bundle exec rake db:mongoid:create_indexes

```

### Localization

```ruby
class Book
  include Mongoid::Document

  #...
  field :currency, localize: true
end

```

Now we can play around with this localized field.

```
irb> b = Book.first
 => #<Book _id: 515c634c45db7c9233000001, t(title): nil, price: nil, page_count: nil, published_date: 2013-25-06 00:00:00 UTC, is_best_seller: false, awards: ["Booker Prize", "Pulitzer Prize"], reviews: nil, currency: nil, author_id: nil>
irb> I18n.locale
 => :en 
irb> b.currency = "GBP"
 => "GBP" 
irb> b.save
 => true 
irb> I18n.locale = :hi
 => :hi 
irb> b.currency = 'INR'
 => "INR" 
irb> b.save
 => true”
```

#### Query

```ruby
irb> Book.where("currency.hi" => 'INR').first
 => #<Book _id: 515c634c45db7c9233000001, t(title): nil, price: nil, page_count: nil, published_date: 2013-25-06 00:00:00 UTC, is_best_seller: false, awards: ["Booker Prize", "Pulitzer Prize"], reviews: nil, currency: {"en"=>"GBP", "hi"=>"INR"}, author_id: nil>
```
