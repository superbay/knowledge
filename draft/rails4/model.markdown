### has_many uniq


generate sql without an ORDER.

```ruby
has_many :comments, :order => :updated_at
has_many :users, :uniq => true, :through => :comments
```

In Rails 4, ORDER is preserved (breaking postgresql).

```ruby
has_many :comments, -> {order(:updated_at)}
has_many :users, -> {uniq}, :through => :comments
```


```ruby
has_many :users, -> { unscope(:order).uniq }, :through => :comments


```



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

### like function 

```ruby
Question.where(Question.arel_table[:content].matches("%#{string}%"))

Question.where("content LIKE ?" , "%#{farming}%")

Question.where("content LIKE :query" , query: "%#{farming}%")
```
