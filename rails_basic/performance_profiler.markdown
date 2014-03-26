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
