### session hijacking


normally We just set the session, more secure we need the recheck the cookie

`cookies.signed[:secure_user_id] = {secure: true, value: "secure#{user.id}"}`

The creatation will let below:

```ruby

def create
  user = User.find_by_name(params[:name])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    cookies.signed[:secure_user_id] = {secure: true, value: "secure#{user.id}"}
    redirect_to(session.delete(:return_to) || root_url)
  else
    flash.now.alert = "Email or password is invalid"
    render "new"
  end
end

```

While destroy the seesion

```ruby
def destroy
  session[:user_id] = nil
  cookies.delete[:secure_user_id]
  redirect_to login_url
end
```

While check the setting

```ruby

def current_user
  if !request.ssl? || cookies.signed[:secure_user_id] == "secure#{session[:user_id]}"
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

```

### Some page use ssl some page not ssl

```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :https_redirect

private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  def https_redirect
    if ENV["ENABLE_HTTPS"] == "yes"
      if request.ssl? && !use_https? || !request.ssl? && use_https?
        protocol = request.ssl? ? "http" : "https"
        flash.keep
        redirect_to protocol: "#{protocol}://", status: :moved_permanently
      end
    end
  end
  
  def use_https?
    true # Override in other controllers
  end  
end
```

view using ssl

```
<%= link_to "Log In", login_url(protocol: "https") %>
```

### Other ssl certification related

```
openssl req -new -nodes -keyout server.key -out server.csr

openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
```

20$ certification

