#### reuse query block

```ruby
tags_query = lambda do |boolean|
  boolean.should { string 'tags:ruby' }
  boolean.should { string 'tags:java' }
end

published_on_query = lambda do |boolean|
  boolean.must   { string 'published_on:[2011-01-01 TO 2011-01-02]' }
end

Tire.search('articles') { query { boolean &tags_query } }

Tire.search('articles') do
  query do
    boolean &tags_query
    boolean &published_on_query
  end
end
```


