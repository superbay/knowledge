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

### send back array using json

```javascript
var dataToSend = { 
    page: location.href, 
    data: []
};
var dataindex = 0;
jQuery(".myclass").each(function(){
    var temp = unique_selector(jQuery(this), "");
    dataToSend.data[dataindex++] = {
        selector: temp,
        contents: jQuery(temp).html()
    };
});
jQuery.ajax({
    type: 'POST',
    url: "/main/save.php",
    data: JSON.stringify(dataToSend),
    dataType: "json",
    success: function(data){ alert(data); }
});
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


server controller

```ruby
# app/controllers/users_controller.rb
# ......
def create
  @user = User.new(params[:user])
 
  respond_to do |format|
    if @user.save
      format.html { redirect_to @user, notice: 'User was successfully created.' }
      format.js   {}
      format.json { render json: @user, status: :created, location: @user }
    else
      format.html { render action: "new" }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end
```

```coffeescript
#app/views/users/create.js.erb
$("<%= escape_javascript(render @user) %>").appendTo("#users");

```



