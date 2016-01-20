### 3 console tips from 37 signals

#### using app

```ruby
app.class
#=> ActionDispatch::Integration::Session
```

#### route path

```ruby
app.project_path(Project.first)
#=> "/projects/130349783-with-attachments"
```

```ruby
app.user_omniauth_authorize_path(:twitter)
# => "/users/auth/twitter"
```

#### trigger a request

```ruby
app.get "/735644780/projects/605816632-bcx.atom" 
#=> 200

app.response.body
#=> "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<feed xml:lang=\"en-US\"  ...
```

### Try out a helper

```ruby
#helper.truncate("Testing", length: 4)
=> "T..." 

#helper.link_to "Home", app.root_path
=> "<a href=\"/\">Home</a>"
```

also can visit local instance

```ruby
def title_tag(title = nil)
  if @project.present? && title.nil?
    content_tag :title, @project.name
  elsif @project.present?
    content_tag :title, "#{@project.name}: #{title}" 
  else
    content_tag :title, title
  end
end

helper.title_tag "Testing!" 
#=> "<title>Testing!</title>" 

helper.instance_variable_set :@project, Project.first
#=> #<Project id: 130349783, ...

helper.title_tag
#=> "<title>With attachments!</title>" 

helper.title_tag "Posts" 
#=> "<title>With attachments!: Posts</title>"

```

### Where does that method come from?

```ruby
Project.instance_method(:trash).source_location
#=> ["/Users/qrush/37s/apps/bcx/app/models/project.rb", 90]

app.method(:get).source_location
=> ["/Users/qrush/.rbenv/versions/1.9.3-p194/lib/ruby/gems/1.9.1/bundler/gems/rails-7d95b814583b/actionpack/lib/action_dispatch/testing/integration.rb", 32]

```


#### bundle with proxy

```bash
http_proxy=http://yourproxy.com bundle install
```



####controller 

```ruby
> app.get '/posts/1'
> response = app.response
# you now have a rails response object much like the integration tests

> response.body            # get you the HTML
> response.cookies         # hash of the cookies
```


controller method

```ruby
foo = ActionController::Base::ApplicationController.new
foo.some_method 


#Route Helpers:

app.myresource_path
app.myresource_url


#View Helpers:

foo = ActionView::Base.new
foo.javascript_include_tag 'myscript'
<or>
helper.link_to "foo", "bar"
<or>
ActionController::Base.helpers.image_tag('logo.png')

#Render:

views = Rails::Application::Configuration.new(Rails.root).paths["app/views"]
views_helper = ActionView::Base.new views
views_helper.render 'myview/mytemplate'
views_helper.render file: 'myview/_mypartial', locals: {my_var: "display:block;"}



```




