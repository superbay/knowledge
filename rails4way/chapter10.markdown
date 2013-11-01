## Action View

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
partial:'entry',collection:@entries
```


#### partial counter

```ruby
end




