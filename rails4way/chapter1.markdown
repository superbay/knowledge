### Gemfile

```ruby
gem'nokogiri',path:'~/code/nokogiri'


gem'carrierwave',github: 'jnicklas/carrierwave'
#Gemspecs with binaries or C extensions are also supported.
gem'nokogiri', git:'git://github.com/tenderlove/nokogiri.git'
```


```ruby
bundle package
```


```ruby
#configuration
config.eager_load=false



```

```ruby
config.action_controller.perform_caching = true # for testing in development mode
```
