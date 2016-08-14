## Parallel Hierarchy

<img width="590" alt="screen shot 2016-08-13 at 10 57 39 pm" src="https://cloud.githubusercontent.com/assets/83296/17646840/72bd23fa-61a9-11e6-8a6f-78d7ea4c1f24.png">


```ruby

post "/" do
  course = Course.new
  course.name     = params.fetch("name")
  course.duration = params.fetch("duration")
  course_list << course
  redirect to("/")
end

```


About Duration

```ruby
Course = Struct.new(:name, :duration) do
  def duration=(new_duration)
    self[:duration] = Duration(new_duration)
  end
  
  
end


def Duration(raw_value)
  case raw_value
  when Duration
    raw_value
  when /\A(\d+)\s+months\z/i
    Months[$1.to_i]
  when /\A(\d+)\s+weeks\z/i
    Weeks[$1.to_i]
  when /\A(\d+)\s+days\z/i
    Days[$1.to_i]
  else
    fail ArgumentError, "Invalid duration: #{raw_value.inspect}"
  end
end
 



```


 
