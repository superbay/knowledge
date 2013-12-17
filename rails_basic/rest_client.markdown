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
