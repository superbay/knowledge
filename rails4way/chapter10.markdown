## Action View

#### yeild

```ruby
%body
  .left.sidebar
= yield :left .content
= yield .right.sidebar
= yield :right
```

then, the place to call it

```ruby
- content_for:left do 
  %h2 Navigation
  %ul
    %li ...
- content_for:right do
  %h2 Help
  %p Lorem ipsum dolor sit amet, consectetur adipisicing elit...

%h1 PageHeading 
  %p...
```




