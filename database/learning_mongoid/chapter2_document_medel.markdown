#### Field aliases

```ruby
class Book
  include Mongoid::Document

  field :t, as: :title, type: String
end

```


better way to create alias and index

```ruby
“class Contact
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
end”
 
```

excute the index

```
bundle exec rake db:mongoid:create_indexes

```
