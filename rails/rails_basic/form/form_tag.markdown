### nested params

append a text_field_tag to a form_for?


If you include a
```ruby
   <%= text_field_tag 'firstname' %>
```
in your form, then you can get the value in the controller using
```ruby
   params[:firstname]
```

If you use nested resources, a
```ruby
   <%= text_field_tag 'user[firstname]' %>
```
in your form, will result in
```ruby
   params[:user][:firstname]
```
in your controller.


```ruby
f.hidden_field :task_id, :value => task.id

```


### another example

```ruby
    = form_tag create_label_path, remote: true do
      = label_tag :name, 'add label'
      .label
        = text_field_tag 'desk_label[name]'
      .label
        = submit_tag 'Submit'
```


controller

```ruby
[1] pry(#<HomeController>)> params
=> {"utf8"=>"✓",
 "desklabel"=>{"name"=>"abc"},
 "commit"=>"Submit",
 "action"=>"create_label",
 "controller"=>"home"}
```




