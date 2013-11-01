## Action View

#### yeild

```ruby
%body
  .left.sidebar
= yield :left .content
= yield .right.sidebar
= yield :right
```



