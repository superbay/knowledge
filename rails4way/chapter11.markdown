## About Helper



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
