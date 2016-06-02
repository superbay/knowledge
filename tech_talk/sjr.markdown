## Ruby 实用技巧之 SJR


### What's SJR

Main point render

`create.js.erb`

### How to render coffee and still using erb


#### Server-generated JavaScript Responses


render `create.js.coffee.erb`


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

```ruby
respond_to do |format|

  format.html # show.html.erb
  format.json { render json: @user }

 end
 
respond_to do |format|
  format.js { render :json { :only => :name }.to_json }
end
```

something not related

```ruby
def create
  @project = Project.find(params[:project_id])
  @task = @project.comments.build(params[:task])
  flash[:notice] = 'Task was successfully created.' if @task.save
  respond_with(@project, @task)
end
```

example to use it

```ruby
respond_to :html, :xml

def create
  @user = User.new(params[:user])
  flash[:notice] = 'User was successfully created.' if @user.save
  respond_with(@user)
end
```

is equivalent, in the absence of create.html.erb, to -


```ruby
def create
  @user = User.new(params[:user])
  respond_to do |format|
    if @user.save
      flash[:notice] = 'User was successfully created.'
      format.html { redirect_to(@user) }
      format.xml { render xml: @user }
    else
      format.html { render action: "new" }
      format.xml { render xml: @user }
    end
  end
end
```

[refrence](http://edgeapi.rubyonrails.org/classes/ActionController/MimeResponds.html#method-i-respond_to)

  4.Server generates a JavaScript response with the HTML embedded.

```ruby  
<%# renders messages/_message.html.erb %>
$('#messages').prepend('<%=j render @message %>');
$('#<%= dom_id @message %>').highlight();
```


```
$('#comments ul.comments').append("<%= escape_javascript render(:partial => 'comments/single', :locals => { :c => @comment }) %>");

$(".commentvotecount<%= params[:commentid]%>").html("<%= escape_javascript link_to('About', '/about') %>");
```



### Why not json + api

Benefit #1: Reuse templates without sacrificing performance


Benefit #2: Less computational power needed on the client

Benefit #3: Easy-to-follow execution flow

### When should We use json 

### solution 

[Russian Doll-caching](http://37signals.com/svn/posts/3112-how-basecamp-next-got-to-be-so-damn-fast-without-using-much-client-side-ui), [Turbolinks](https://github.com/rails/turbolinks), and SJR 



### something more

[csrf](../rails4way/chapter15.markdown)

[Rails 4.1 Beta](../rails4.1/major_features.markdown)
