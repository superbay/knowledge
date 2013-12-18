### Action View Render Partial with block


### Render partial with layouts


```ruby

<%# app/views/users/index.html.erb &>
Here's the administrator:
<%= render partial: "user", layout: "administrator", locals: { user: administrator } %>

Here's the editor:
<%= render partial: "user", layout: "editor", locals: { user: editor } %>

<%# app/views/users/_user.html.erb &>
Name: <%= user.name %>

<%# app/views/users/_administrator.html.erb &>
<div id="administrator">
  Budget: $<%= user.budget %>
  <%= yield %>
</div>

<%# app/views/users/_editor.html.erb &>
<div id="editor">
  Deadline: <%= user.deadline %>
  <%= yield %>
</div>
```
