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
