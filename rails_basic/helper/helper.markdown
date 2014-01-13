### content_tag

```ruby

content_tag(:p, "Hello world!")
 # => <p>Hello world!</p>
content_tag(:div, content_tag(:p, "Hello world!"), class: "strong")
 # => <div class="strong"><p>Hello world!</p></div>
content_tag("select", options, multiple: true)
 # => <select multiple="multiple">...options...</select>

<%= content_tag :div, class: "strong" do -%>
  Hello world!
<% end -%>
 # => <div class="strong">Hello world!</div>
 
```


```ruby
content_tag(:li, nil, :class => 'someClass') {
  arr.reduce('') { |c, x|
    c << content_tag(:ul, x)
  }.html_safe
}
```
