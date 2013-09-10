### the way to Gemfile

```ruby
gem'carrierwave',git:'git@github.com:jnicklas/carrierwave.git'
gem'carrierwave',github:'jnicklas/carrierwave'
```

### route

```ruby
match':controller(/:action(/:id(.:format)))',via::any
get"/foo",to:redirect('/bar')
get"/google",to:redirect('http://google.com/')

#redirect
match"/api/v1/:api",to: redirect {|params| "/api/v2/#{params[:api].pluralize}" }, via: :any

match"/api/v1/:api",:to=> redirect(status: 302) {|params| "/api/v2/#{params[:api].pluralize}" }, via: :any
```
