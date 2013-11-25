### how to test engine routes


after rspec 2.14

```ruby
describe "Auths page routing" do
  routes { Utilizer::Engine.routes }
  # ...
end
```
