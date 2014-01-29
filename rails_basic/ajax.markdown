### example of how ajax with remote true and SJR

```ruby
<%= form_for(@post, remote: true) do |f| %>
  ...
<% end %>

<%= form_tag('/posts', remote: true) %>



```


```coffeescript

$(document).ready ->
  $("#new_post").on("ajax:success", (e, data, status, xhr) ->
    $("#new_post").append xhr.responseText
  ).bind "ajax:error", (e, xhr, status, error) ->
    $("#new_post").append "<p>ERROR</p>"
    

```


for link

```erb
<%= link_to "a post", @post, remote: true %>
```


```coffeescript
$ ->
  $("a[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    alert "The post was deleted."    
    
```



