
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




