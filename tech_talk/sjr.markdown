## Server-generated JavaScript Responses


#### Complete example

  1.First-use of the message template.

```ruby

<h1>All messages:</h1>
<%# renders messages/_message.html.erb %>
<%= render @messages %>
```

  2.Form submitting via Ajax.

```ruby
<% form_for @project.messages.new, remote: true do |form| %>
  ...
  <%= form.submit "Send message" %>
<% end %>

```


  3.Server creates the model object.


```ruby
class MessagesController < ActionController::Base
  def create
    @message = @project.messages.create!(message_params)

    respond_to do |format|
      format.html { redirect_to @message } # no js fallback
      format.js   # just renders messages/create.js.erb
    end
  end
end
```

  4.Server generates a JavaScript response with the HTML embedded.

```ruby  
<%# renders messages/_message.html.erb %>
$('#messages').prepend('<%=j render @message %>');
$('#<%= dom_id @message %>').highlight();
```


### Why not json + api

Benefit #1: Reuse templates without sacrificing performance


Benefit #2: Less computational power needed on the client

Benefit #3: Easy-to-follow execution flow

### When should We use json 

### solution 

Russian [Doll-caching](http://37signals.com/svn/posts/3112-how-basecamp-next-got-to-be-so-damn-fast-without-using-much-client-side-ui), [Turbolinks](https://github.com/rails/turbolinks), and SJR 
