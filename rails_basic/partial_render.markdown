### Action View Render Partial with block


```ruby
<%# app/views/users/_chief.html.erb &>
<%= render(layout: "administrator", locals: { user: chief }) do %>
  Title: <%= chief.title %>
<% end %>
```


 return

```ruby

<div id="administrator">
  Budget: $<%= user.budget %>
  Title: <%= chief.name %>
</div>

```

#### with yield


As you can see, the :locals hash is shared between both the partial and its layout.

If you pass arguments to “yield” then this will be passed to the block. One way to use this is to pass an array to layout and treat it as an enumerable.

```ruby
<%# app/views/users/_user.html.erb &>
<div class="user">
  Budget: $<%= user.budget %>
  <%= yield user %>
</div>

<%# app/views/users/index.html.erb &>
<%= render layout: @users do |user| %>
  Title: <%= user.title %>
<% end %>
```ruby


This will render the layout for each user and yield to the block, passing the user, each time.


You can also yield multiple times in one layout and use block arguments to differentiate the sections.

```ruby
<%# app/views/users/_user.html.erb &>
<div class="user">
  <%= yield user, :header %>
  Budget: $<%= user.budget %>
  <%= yield user, :footer %>
</div>

<%# app/views/users/index.html.erb &>
<%= render layout: @users do |user, section| %>
  <%- case section when :header -%>
    Title: <%= user.title %>
  <%- when :footer -%>
    Deadline: <%= user.deadline %>
  <%- end -%>
<% end %>
```


### Render partial with layouts


```ruby

# app/views/users/index.html.erb
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
Here's the administrator:
```ruby
<div id="administrator">
  Budget: $<%= user.budget %>
  Name: <%= user.name %>
</div>

Here's the editor:
<div id="editor">
  Deadline: <%= user.deadline %>
  Name: <%= user.name %>
</div>
```

### collection

```ruby
<%# app/views/users/_user.html.erb %>
Name: <%= user.name %>

<%# app/views/users/index.html.erb %>
<%# This does not use layouts %>
<ul>
  <% users.each do |user| -%>
    <li>
      <%= render partial: "user", locals: { user: user } %>
    </li>
  <% end -%>
</ul>

<%# app/views/users/_li_layout.html.erb %>
<li>
  <%= yield %>
</li>

<%# app/views/users/index.html.erb %>
<ul>
  <%= render partial: "user", layout: "li_layout", collection: users %>
</ul>

```

result


```ruby
<ul>
  <li>
    Name: Alice
  </li>
  <li>
    Name: Bob
  </li>
</ul>
```



