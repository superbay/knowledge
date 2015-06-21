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

[gem solution dotenv](https://github.com/bkeepers/dotenv)
### heroku config

heroku-config is a plugin for the Heroku CLI that makes it easy to grab your application’s config vars, and place them in your local .env, and vice versa.

```
 heroku plugins:install git://github.com/ddollar/heroku-config.git
heroku-config installed
```


```
 heroku config:pull --overwrite --interactive
```


```
heroku config:push
```
 




### heroku rename

```ruby
$ heroku apps:rename newname
#http://newname.heroku.com/ | git@heroku.com:newname.git
#Git remote heroku updated
```


You can rename an app while outside a git checkout by passing an explicit --app argument:

```ruby
$ heroku apps:rename newname --app oldname
#http://newname.heroku.com/ | git@heroku.com:newname.git
```





