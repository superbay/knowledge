### search all file and all content


```

find . -name \*.* | xargs grep 'GMAT'

```

pay more attion about the '\'


### search all files and replace

```ruby
#Remove FactoryGirl.
find . -type f -name *_spec.rb -print | xargs  sed -ie 's/FactoryGirl\.//g'

```
