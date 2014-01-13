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

```ruby
arr = ['a','b','c']
content_tag :div do 
  arr.collect { |letter| content_tag(:scan, letter) 
end

arr = ["a", "b", "c"]
content_tag(:ul, :class => 'a class') do
  arr.each do |item|
  concat content_tag(:li, item)
end

#=> <div>
#      <scan>a</scan>
#      <scan>b</scan>
#      <scan>c</scan>
#   </div>


```

### one more example

```ruby

module MyHelper
  def widget
    content_tag(:p, class: "widget") do
      link_to("Hello", hello_path) + " " + link_to("Bye", goodbye_path)
    end
  end
end
#should be

module MyHelper
  def widget
    content_tag(:p, class: "widget") do
      concat link_to("Hello", hello_path)
      concat " "
      concat link_to("Bye", goodbye_path)
    end
  end
end
```

if it display twice

```ruby

module MyHelper
  def widget
    concat link_to("Hello", hello_path)
    concat " "
    concat link_to("Bye", goodbye_path)
  end
end

#to be

module MyHelper
  def widget
    capture do
      concat link_to("Hello", hello_path)
      concat " "
      concat link_to("Bye", goodbye_path)
    end
  end
end

```

