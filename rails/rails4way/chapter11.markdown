## About Helper



[other select related](../rails_basic/form/select_tag.markdown)



#### select && options

```ruby
= select(:post, :person_id, Person.all.collect {|p| [ p.name, p.id ] }, { include_blank: true })
collection_select(object, method, collection, value_method, text_method, options = {}, html_options = {})

option_groups_from_collection_for_select(@continents,:countries, :continent_name, :country_id, :country_name, @selected_country.id)


options_from_collection_for_select(Person.all,:id,:name)



options_for_select({ "Basic" => "20", "Plus" => "40" }, price.to_s) 
#=><optionvalue="20">Basic</option>
# <option value="40" selected="selected">Plus</option>
```




In case you’re wondering, the authenticity_token hidden field with gibberish up near the top of the form has to do with protection against malicious Cross-Site Request Forgery (CSRF) attacks.


#### Resource-oriented Style

```ruby
= form_for post do |f|
# will be equivalent to
= form_for post, as: :post, url: post_path(post), method: :patch, html: { class: "edit_post", id: "edit_post_45" } do |f|


= form_for(Post.new) do |f|
#expands to
= form_for post, as: :post, url: posts_path, html: { class: "new_post", id: "new_post" } do |f|

```




#### date_select and time_select


```ruby
time_select("post", "written_on", include_seconds: true)
date_select("post", "written_on")
date_select("post", "written_on",start_year: 1995, use_month_numbers: true, discard_day: true, include_blank: true)
date_select("post","written_on",order:[:day,:month,:year]) date_select("user", "birthday", order: [:month, :day])

```

### the new date helper with default date picker

```ruby
date_field
```

[date_field reference](http://guides.rubyonrails.org/form_helpers.html)




#### content_for && content_for?

```ruby
-content_for: navigation_sidebar do
  = link_to 'Detail Page', item_detail_path(item)
```


according which content, yield with different class name

```ruby
%body{class: content_for?(:right_col) ? 'one-column' : 'two-column'} 
  = yield
  = yield :right_col
```

#### AtomFeedHelper

```ruby

atom_feed do|feed|
  feed.title("My great blog!") 
  feed.updated(@posts.first.created_at)
  @posts.each do |post| 
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(post.body, type: 'html')
      entry.author do |author|
        author.name("DHH")
      end 
    end
  end 
end

```

#### Using Asset Hosts

```ruby
config.action_controller.asset_host= "assets.example.com"
```

#### video_tag

```ruby
video_tag("trail.m4v", size: "16x10", poster: "screenshot.png")
# => <video src="/videos/trailer.m4v" width="16" height="10"
# poster="/images/screenshot.png" />
```

then the image_tag and the stylesheet_link_tag will change accordingly

```ruby
image_tag("rails.png")
#=> <imgalt="Rails" src= "http://assets.example.com/images/rails.png?1230601161"/>
```

#### asset Host advance

```ruby
config.action_controller.asset_host = Proc.new do |source|
  if source.starts_with?('/images')

    'http://images.example.com'
  else
    'http://assests.example.com'
  end
end
```

#### advance assets according to request and source

```ruby
ActionController::Base.asset_host = Proc.new do |source, request|
  if request.ssl?
    "#{request.protocol}#{request.host_with_port}"
  else
    "#{request.protocol}assets.example.com"
  end
end

```

Here also the way to test this function via console:

```ruby
config.action_controller.asset_host = AssetHostingWithMinimumSsl.new(
  "http://asset%d.example.com", "https://asset1.example.com"
)
```


#### stylesheet_link_tag(*sources)

```ruby
stylesheet_link_tag"style"
#=><linkhref="/stylesheets/style.css"media="screen"
# rel="Stylesheet"type="text/css"/>

stylesheet_link_tag"style",media:"all"
#=><linkhref="/stylesheets/style.css"media="all"
# rel="Stylesheet"type="text/css"/>

```


#### javascript_include_tag(*sources)

```ruby
javascript_include_tag"xmlhr"
#=><scriptsrc="/assets/xmlhr.js?1284139606"></script>

javascript_include_tag"common","/elsewhere/cools"
#=><scriptsrc="/assets/common.js?1284139606"></script>
# <script src="/elsewhere/cools.js?1423139606"></script>
```
#### auto_discovery_link_tag

```ruby

auto_discovery_link_tag
#=><linkrel="alternate"type="application/rss+xml"title="RSS"
# href="http://www.currenthost.com/controller/action"/>


auto_discovery_link_tag(:rss,{action:"feed"})
#=><linkrel="alternate"type="application/rss+xml"title="RSS"
# href="http://www.currenthost.com/controller/feed"/>
```
