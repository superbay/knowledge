
### install memcached



Install memcached 1.4.x using Homebrew with
```
brew install memcached
```

On Ubuntu you can install it by running:

```
apt-get install memcached
```

You can verify your installation using this piece of code:

```
gem install dalli
```

### restart memcached


```
service memcached restart
```


```
config.cache_store = :dalli_store, 'cache-1.example.com', 'cache-2.example.com',
  { :namespace => NAME_OF_RAILS_APP, :expires_in => 1.day, :compress => true }
```

