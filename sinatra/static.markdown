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
