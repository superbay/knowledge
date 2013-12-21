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

