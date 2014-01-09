## Rails Environment Variables


A less useful alternative to using Foreman’s .env file is to set these values in the ~/.bashrc for the user:

```ruby
#~/.bashrc
export S3_KEY=mykey
export S3_SECRET=mysecret

```

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :developer unless Rails.env.production?
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
```
