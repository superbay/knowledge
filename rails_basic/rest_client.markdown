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
