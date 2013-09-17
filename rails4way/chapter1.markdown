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

#Raiseanerroronpageloadiftherearependingmigrations
2 config.active_record.migration_error=:page_load

```

```ruby
config.action_controller.perform_caching = true # for testing in development mode
```
```ruby
match'products/:id'=>'products#show',via::get

```

### backtrace silencer

```ruby
#Youcanaddbacktracesilencersforlibrariesthatyou'reusingbut
#don'twishtoseeinyourbacktraces.
Rails.backtrace_cleaner.add_silencer{|line|line=~/my_noisy_library/}

#Youcanalsoremoveallthesilencersifyou'retryingtodebuga
#problemthatmightstemfromframeworkcode.
Rails.backtrace_cleaner.remove_silencers!

```

```ruby
#Configuresensitiveparameterswhichwillbefilteredfromthelogfile.
Rails.application.config.filter_parameters+=[:password]
config.assets.precompile += %w( administration.css )
```
