### scope with includes

```ruby
  scope :home_article, -> { includes(:articles).where('articles.is_home' => true) }
```

Using #scope without passing a callable object is deprecated. For example `scope :red, where(color: 'red')` should be changed to `scope :red, -> { where(color: 'red') }`.


### instance level includes

```ruby
  has_many :home_articles, -> { where('articles.is_home' => true) }, class_name: 'Article'
```

总之，都要scope了

```ruby
class Blog < ActiveRecord::Base
  has_many :published_posts, -> { where published: true }, class_name: 'Post'
end
```
