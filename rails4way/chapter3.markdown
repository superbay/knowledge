### restful

#### chart

![screen shot 2013-09-29 at 10 58 29 pm](https://f.cloud.github.com/assets/83296/1234530/46455bb6-297c-11e3-8e98-ab7021b110df.png)

#### how to use patch & delete

used jquery-ujs

```ruby
link_to "Delete", auction_path(auction), method: :delete
```

```ruby
form_for "auction", url: auction_path(auction), html: { method: :patch } do |f|
end
```
### sample

```ruby
rake routes
```