#### restful client

using rails console instead of chrome plugin


```ruby
#Gemfile
gem 'rest-client'
gem 'nokogiri'

#console
require 'rest_client'
require 'nokogiri'

RestClient.proxy = 'some.proxy.com'

RestClient.get 'user:password@your.url.com'
```



```ruby
#updated to nil, if author is ken
Video.update_all({author_id: nil}, {author_id: 'ken'})
```

### Nokogiri

```ruby
  doc.css('div[@class="title"]').each do |div|
      div.children.first.replace Nokogiri::HTML::DocumentFragment.parse(div.text).children
  end
```


```ruby
text="<html><body><div class='body'><p class='main'>some text here</p></div></body></html>"
doc = Nokogiri::HTML(text)
root = doc.root
node = doc.xpath('//p[@class="main"]').first
path = [node]
begin
  node = node.parent
  path.unshift node
end until node == root
path.map {|n| n.name}.join " > "
```


#### replace a element

```ruby
doc.css("div.to-replace").each do |div|
    new_node = doc.create_element "span"
    new_node.inner_html = self.get_html_text
    div.replace new_node
end
```

#### builder

```ruby
builder = Nokogiri::HTML::Builder.new do |doc|
doc.html {
  doc.body(:onload => 'some_func();') {
    doc.span.bold {
      doc.text "Hello world"
    }
  }
}
end
puts builder.to_html
```
