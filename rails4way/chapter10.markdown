## Action View


```ruby
javascript_include_tag"xmlhr"
#=><scriptsrc="/assets/xmlhr.js?1284139606"></script>
```


### custom validation error display

```ruby
module ActionView
  class Base
    cattr_accessor :field_error_proc
    @@field_error_proc = Proc.new{ |html_tag, instance|
      "<div class=\"field_with_errors\">#{html_tag}</div>".html_safe
    }
  end
end
```


### form creation

will generate those things

```ruby
form("post")
#<formaction='/posts/create'method='post'>
#  <p>
#    <label for="post_title">Title</label><br />
#    <input id="post_title" name="post[title]" size="30" type="text"
#      value="Hello World" />
#  </p>
#  <p>
#    <label for="post_body">Body</label><br />
#    <textarea cols="40" id="post_body" name="post[body]" rows="20"></textarea>
#  </p>
#  <input name="commit" type="submit" value="Create" />
#</form>
```

### automatic form generate 

```ruby
form("entry",:action=>"sign", :input_block => Proc.new { |record, column|
  "#{column.human_name}: #{input(record, column.name)}<br />"
})

#<form action="/entries/sign"method="post">
#  <input id="entry_message" name="entry[message]" size="30"
#    type="text" /><br />
#  <input name="commit" type="submit" value="Sign" />
#</form>
```

add content to form

```ruby

form("entry",:action=>"sign")do|form|
  form << content_tag("b", "Department")
  form << collection_select("department", "id", @departments, "id", "name")
end
```

input

```ruby
input("post", "title") 
#=><input id="post_title" name="post[title]" size="30"
# type="text" value="HelloWorld"/>
```

### form_for

```ruby
= form_for @person do |form| 
  = form.error_messages .text-field
    = form.label :name, "Name"
    = form.text_field :name
```

#### reference learn error message

[error_messages_for](reference/error_messages_for.markdown)

#### yeild

```ruby
%body
  .left.sidebar
= yield :left .content
= yield .right.sidebar
= yield :right
```

then, the place to call it

```ruby
- content_for:left do 
  %h2 Navigation
  %ul
    %li ...
- content_for:right do
  %h2 Help
  %p Lorem ipsum dolor sit amet, consectetur adipisicing elit...

%h1 PageHeading 
  %p...
```

#### instance variables

#### assigns
Want to see everything that comes across the controller-view boundary? Throw = `debug(assigns)` into your template and take a look at the output. The assigns attribute is essentially internal to Rails and you should not use it directly in your production code.

#### flash.now

```ruby
class ReportController < ActionController::Base
  def create
    if report.save
      flash.notice = "#{report.title} has been created."
      redirect_to report_path(report)
    else
      flash.now.alert = "#{@post.title} could not be created."
      render :new 
    end
  end 
end
```

#### partial collection

```ruby
partial: 'entry', collection: @entries
```


#### partial counter

```ruby
There’s another variable set for collection-rendered partials that doesn’t get much attention. It’s a 0-indexed counter variable that tracks the number of times the partial has gotten rendered. It’s useful for rendering numbered lists of things. The name of the variable is the name of the partial, plus _counter.
```ruby
= div_for(entry) do
  #{entry_counter}: #{entry.description} 
  #{distance_of_time_in_words_to_now entry.created_at} ago
end

```

```ruby
error_message_on(object, method, *options)
```

