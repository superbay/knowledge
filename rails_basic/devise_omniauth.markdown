### tips


1 the key and token

twitter app need comsumer key and consumer secret 

```ruby
config.omniauth :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
```

2 the twitter app call back 

just need to be the whole site


3 should redirect

    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      redirect_to new_user_registration_url
    end
    
    
    
### facebook omniauth authentication

```
This app is in sandbox mode.  Edit the app configuration at http://developers.facebook.com/apps to make the app publicly visible.
```

could be the problem of sandbox, try to recreate the app at facebook to disable sanbox


