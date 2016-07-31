Rake Custom Task


normal utility: automating file transfermation

example of post local file to P blogging service


```ruby
require "rubypress"
 
WPCLIENT = Rubypress::Client.new(
  host:     ENV.fetch("WP_HOST"),
  username: ENV.fetch("WP_USERNAME"),
  password: ENV.fetch("WP_PASSWORD"),
  use_ssl:  true)
 
```


straightforward define a Rake task that uploads blog post based on the contents of a local HTML file


```ruby
task "blogpost" do
  WPCLIENT.newPost(
    content: {
      post_status: "publish",
      post_content: File.read("post_content.html"),
      post_title: "Hello World" })
end
```
 
 


