## Action View

```ruby
= form_for @person do |form| 
  = form.error_messages .text-field
    = form.label :name, "Name"
    = form.text_field :name
    
```


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

