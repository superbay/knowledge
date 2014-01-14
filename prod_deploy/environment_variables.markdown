## Rails Environment Variables


A less useful alternative to using Foreman’s .env file is to set these values in the ~/.bashrc for the user:

```ruby
#~/.bashrc
export TWITTER_KEY=mykey
export TWITTER_SECRET=mysecret


```

Rails environment:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
```

for heroku setting:

```ruby
heroku config:set SECRET_KEY_BASE=value
```

[heroku reference](https://devcenter.heroku.com/articles/config-vars)

[gem solution](https://github.com/bkeepers/dotenv)



