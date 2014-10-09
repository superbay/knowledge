



```ruby

autoload_paths 

```



in config/application.rb:

config.autoload_paths << Rails.root.join('lib')
and keep the right naming convention in lib.

in lib/foo.rb:

class Foo
end
in lib/foo/bar.rb:

class Foo::Bar
end
if you really wanna do some monkey patches in file like lib/extensions.rb, you may manually require it:

in config/initializers/require.rb:

require "#{Rails.root}/lib/extensions" 
