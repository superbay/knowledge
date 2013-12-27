### OmniAuth::Strategies::OAuth2::CallbackError

```ruby
Started GET "/auth/facebook/callback" for 127.0.0.1 at 2012-11-16 15:16:03 -0600
(facebook) Callback phase initiated.
(facebook) Authentication failure! invalid_credentials: OmniAuth::Strategies::OAuth2::CallbackError, OmniAuth::Strategies::OAuth2::CallbackError

OmniAuth::Strategies::OAuth2::CallbackError (OmniAuth::Strategies::OAuth2::CallbackError)

```


solution:


https://github.com/intridea/omniauth-oauth2/issues/32 -> Add this to your provider declaration : 

```ruby

provider :facebook, xxxxxxxxx, yyyyyyyyy, {:provider_ignores_state => true}

```

[reference](http://stackoverflow.com/questions/13425757/rails-facebook-login-error-with-omniauth-facebook-omniauthstrategiesoauth2)


