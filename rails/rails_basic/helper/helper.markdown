### titleize



```ruby
require "active_support/inflector"

'man from the boondocks'.titleize   # => "Man From The Boondocks"
```


### content_tag

```ruby

content_tag(:p, "Hello world!")
 # => <p>Hello world!</p>
content_tag(:div, content_tag(:p, "Hello world!"), class: "strong")
 # => <div class="strong"><p>Hello world!</p></div>
content_tag("select", options, multiple: true)
 # => <select multiple="multiple">...options...</select>

<%= content_tag :div, class: "strong" do -%>
  Hello world!
<% end -%>
 # => <div class="strong">Hello world!</div>
 
```


```ruby
content_tag(:li, nil, :class => 'someClass') {
  arr.reduce('') { |c, x|
    c << content_tag(:ul, x)
  }.html_safe
}
```

```ruby
arr = ['a','b','c']
content_tag :div do 
  arr.collect { |letter| content_tag(:scan, letter) 
end

arr = ["a", "b", "c"]
content_tag(:ul, :class => 'a class') do
  arr.each do |item|
  concat content_tag(:li, item)
end

#=> <div>
#      <scan>a</scan>
#      <scan>b</scan>
#      <scan>c</scan>
#   </div>


```

### one more example

```ruby

module MyHelper
  def widget
    content_tag(:p, class: "widget") do
      link_to("Hello", hello_path) + " " + link_to("Bye", goodbye_path)
    end
  end
end
#should be

module MyHelper
  def widget
    content_tag(:p, class: "widget") do
      concat link_to("Hello", hello_path)
      concat " "
      concat link_to("Bye", goodbye_path)
    end
  end
end
```

if it display twice

```ruby

module MyHelper
  def widget
    concat link_to("Hello", hello_path)
    concat " "
    concat link_to("Bye", goodbye_path)
  end
end

#to be

module MyHelper
  def widget
    capture do
      concat link_to("Hello", hello_path)
      concat " "
      concat link_to("Bye", goodbye_path)
    end
  end
end

```

### use helper method in model

```ruby
ApplicationController.helpers.your_helper_methord 
#or 
YourController.helpers.your_helper_method
#example
ActionController::Base.helpers.number_to_currency(read_attribute :oprice)

Rails.application.routes.url_helpers.page_path(@page)
```

### helper in controller
Using Rails Helpers inside a Controller

```ruby
include HelperName
```

which is same
```ruby

class MyController < ApplicationController
  def action
    @url = UrlHelper.generate_url(current_user)
  end
end
```


```ruby
module EventsHelper
  def do_something
  end
end
Then, in the controller just include it

class BadgeController < ApplicationController
  include EventHelper

  ...
end
```


### use method on view

Declare a controller method as a helper. For example, the following makes the current_user controller method available to the view:
```ruby

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def logged_in?
    current_user != nil
  end
end
```
In a view:
```
<% if logged_in? -%>Welcome, <%= current_user.name %><% end -%>
```

### use view helper in controller

use any view helper in a rails controller by using the view_context object:

  
```ruby
    # app/controllers/phones_controller.rb
    def confirm
      if current_user.confirmed_phone?
        redirect_to edit_phone_path,
          notice: \
            "The phone number #{view_context.format_phone(current_user.phone)}
            is already confirmed."
      end
    end
```

You can see more about the view_context object in the api dock.
