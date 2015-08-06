### baisc tools

```ruby
timing = Benchmark.measure { Post.all }

```


### Gem

https://github.com/MiniProfiler/rack-mini-profiler




### performance and profiler


```ruby

 require 'test_helper' 
 require 'performance_test_help' 
 class PostPerformanceTest < ActionController::PerformanceTest 
   def setup # Application requires logged-in user 
     login_as(:lifo) 
   end 
   
   def test_homepage 
     get '/dashboard' 
   end 
   
   def test_creating_new_post 
     post '/posts', :post => { :body => 'lifo is fooling you' } 
   end 
end 
```


```ruby
require 'test_helper' 
require 'performance_test_help' 
class PostModelTest < ActionController::PerformanceTest 
  def test_creation 
    Post.create :body => 'still fooling you', :cost => '100' 
  end 
  
  def test_slow_method 
    # Using posts(:awesome) fixture 
    posts(:awesome).slow_method 
  end 
end
 
```

```bash
rake test:benchmark
```


#### Controller profile

```ruby
def process_projects 
  self.class.benchmark("Processing projects") do
    Project.process(params[:project_ids]) 
    Project.update_cached_projects 
  end 
end

```


#### View profile

```ruby
<% benchmark("Showing projects partial") do %> 
  <%= render :partial => @projects %> 
<% end %> 
```

[old reference resource](http://guides.rubyonrails.org/v2.3.11/performance_testing.html)
