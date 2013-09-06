```ruby
class Book < ActiveRecord::Base
  has_one :author
  has_many :pages

  accepts_nested_attributes_for :author, :pages
end
```

The attribute writer is named after the association, which means that in the following example, two new methods are added to your model:

author_attributes=(attributes) and pages_attributes=(attributes).
