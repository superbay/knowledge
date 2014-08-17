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


### another error while integration

```
{
   "error": {
      "message": "Invalid redirect_uri: Given URL is not allowed by the Application configuration.",
      "type": "OAuthException",
      "code": 191
   }
}
```

try to set your webapp url if not. or just confirm it


### How to try your facebook open graph api

find your official code sample: 

```ruby
https://graph.facebook.com/me/lkvdemo:review?
access_token=ACCESS_TOKEN&
method=POST&
movie=http://samples.ogp.me/453907197960619
```

parse it to local

```ruby

u = User.last
u.facebook.put_connections("me", "lkvdemo:review", movie: "http://samples.ogp.me/453907197960619")

```


#### OmniAuth::Strategies::OAuth2::CallbackError

Ruby on Rails Devise Oauth-facebook OmniAuth::Strategies::OAuth2::CallbackError

```ruby
require "omniauth-facebook"
config.omniauth :facebook, ENV["FACEBOOK_APP_ID"], ENV['FACEBOOK_SECRET'],{provider_ignores_state: true}
  
```

or 

```ruby

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           :scope => 'email,user_birthday,read_stream', :display => 'popup'
end
```
