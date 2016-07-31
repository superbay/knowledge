## Rake Custom Task


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


raw ruby script, real power of Rake `handling of dependencies`

The real power of Rake lies in its smart handling of dependencies. When we’re working with local files, Rake is able to determine whether a file needs to be re-built or not, by tracing the dependency graph and working out if a prerequisite has been updated.

Wouldn’t it be nice if we could have the same power here? If we could have rake only submit the blog post if it either doesn’t already exist, or if the local file has been updated?


```ruby

class PostTask < Rake::Task
 
def timestamp
  post_info["post_modified_gmt"].to_time
end
 
def post_id
  post_info && post_info["post_id"]
end
 
def post_info
  post_list.detect{|post| post["post_name"] == name}
end
 
def post_list
  @post_list ||= WPCLIENT.getPosts(
    fields: %w[post_id post_name post_modified_gmt])
end
end

```
 
 
Working from bottom to top: first we have a method which fetches and caches a list of blog posts, requesting just a small set of metadata for each post.

Next we have a post_info method which looks up info for the specific post this task pertains to, if it exists.

WordPress posts have an internal “name” string, and for simplicity we’ll be matching up the name of a Rake task with the name of the blog post. If you’re not sure what I mean by the “name of the task”, hang in there. It’ll become more clear shortly.

Building on this info method, we have a convenience method for pulling out the blog post’s ID.

And another helper for getting the blog post’s modification timestamp.



### needed?

It turns out that to customize the dependency calculation for our rake task, we only need to provide a single method.

The #needed? method is what Rake uses to determine if a task needs to be invoked or not.

How do we determine if the blog post needs to be created or updated? We need to check if it doesn’t exist, or if it is out of date compared to its dependencies.

```ruby
def needed?
  !post_exists? || out_of_date?
end
 
```


The post_exists? predicate is simple enough. We’ll just check to see if we have are able to find any post info.



```ruby
def post_exists?
  !!post_info
end

```

Calculating if the post is out of date with regard to prerequisites is a little more tricky. Fortunately, we can cheat.

Let’s check out the implementation of this method in Rake’s FileTask class.


```ruby
def out_of_date?(stamp)
  @prerequisites.any? { |n| application[n, @scope].timestamp > stamp }
end
```

### swipe 

This code goes through the task’s list of prerequisites. That is, the list of other tasks that it depends on. For each prerequisite, it looks up the corresponding task object, and then checks the timestamp to see whether it is newer than this file’s timestamp.

Let’s just swipe this code.

Then we’ll simplify it by removing the parameter and using the timestamp method we defined earlier.

Remember, our timestamp method uses the blog post timestamp as reported by the remote blog server.

The only other change we make is to ensure that the prerequisite timestamps are converted to UTC before the comparison.


```ruby
def out_of_date?
  @prerequisites.any? { |n|
    application[n, @scope].timestamp.utc > timestamp
  }
end
```


### declaring post tasks

We’ll define it exactly the same way Rake’s built-in task and file methods are written, forwarding the arguments and block to the define_task class method.



```ruby
def post(*args, &block)
  PostTask.define_task(*args, &block)
end

desc "Create or update a blog post"
post "my-blog-post" => ["post_content.html"] do |t|

  if t.post_exists?
    puts "Update post ID #{t.post_id}..."
    
  else
    puts "Create new post..."
  end
end

```
![rake_custom1](https://cloud.githubusercontent.com/assets/83296/17273925/4407f83c-5696-11e6-8be9-bbf975665f6b.PNG)
![rake_custom2](https://cloud.githubusercontent.com/assets/83296/17273926/4618fb12-5696-11e6-9e96-1e7f86602aa6.PNG)


### result

![rake_custom](https://cloud.githubusercontent.com/assets/83296/17273857/9c94170e-5693-11e6-8f3f-7566b317287a.PNG)
