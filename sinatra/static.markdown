### Serving static files with Sinatra


```ruby
require 'rubygems'
require 'sinatra'

get '/' do
  File.read(File.join('public', 'index.html'))
end

```

solution2

```ruby


set :public_folder, 'public'

get "/" do
  redirect '/index.html'
end

# which is default to public

set :public_folder, 'public'
get "/" do
  redirect '/subfolder/index.html' 
end
```

solution3


```ruby
get "/subdirectory/:file" do 
  file = params[:file] + "index.html"
  if File.exists?(params[:file])
    return File.open("subdirectory/" + file)
  else
   return "error"
  end
end
```



```ruby
require 'sinatra'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

   get '/static_file' do
      send_file('my_static_file')
   end 


```


### some related settings

#### :static - enable/disable static file routes

Boolean that determines whether static files should be served from the application’s public directory (see the :public_folder setting). When :static is truthy, Sinatra will check if a static file exists and serve it before checking for a matching route.

The :static setting is enabled by default when the public directory exists.

#### :public_folder - static files directory


A string specifying the directory where static files should be served from. By default, this is assumed to be a directory named “public” within the root directory (see the :root setting). You can set the public directory explicitly with:

```ruby
set :public_folder, '/var/www'
```

The best way to specify an alternative directory name within the root of the application is to use a deferred value that references the :root setting:

```ruby
set :public_folder, Proc.new { File.join(root, "static") }
```

#### :views - view template directory

A string specifying the directory where view templates are located. By default, this is assumed to be a directory named “views” within the application’s root directory (see the :root setting). The best way to specify an alternative directory name within the root of the application is to use a deferred value that references the :root setting:

```ruby
set :views, Proc.new { File.join(root, "templates") }
```

[more reference](http://www.sinatrarb.com/configuration.html)
