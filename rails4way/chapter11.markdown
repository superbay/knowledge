## About Helper


#### content_for && content_for?

```ruby
-content_for: navigation_sidebar do
  = link_to 'Detail Page', item_detail_path(item)
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
