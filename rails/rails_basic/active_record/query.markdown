Rails SQL regular expression


```ruby
Drawing.where("drawing_number ~* ?", "^A\d{4}$")

```
