### scope with includes

```ruby
  scope :home_article, -> { includes(:articles).where('articles.is_home' => true) }
```

Using #scope without passing a callable object is deprecated. For example `scope :red, where(color: 'red')` should be changed to `scope :red, -> { where(color: 'red') }`.
