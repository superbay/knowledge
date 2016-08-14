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

### Fixed the display bad UE problem

```ruby
template :course_form do
  <<~EOF
  <h1>Add a course</h1>
  <form action="/" method="POST">
    <div class="form-group">
      <label class="form-label" for="name">Name</label>
      <input class="form-input" type="text" name="name"
             value="<%= course.name %>"/>
    </div>
    <div class="form-group<%= course.duration.nil? && ' has-danger' %>">
      <label class="form-label" for="duration">Duration</label>
      <input class="form-input" type="text" name="duration"
             value="<%= course.duration %>"/>
    </div>
    <div class="form-group">
      <input class="btn btn-primary" name="Create" type="submit"/>
    </div>
  </form>
  EOF
  ```
  
  
  ```ruby
  post "/" do
  course = Course.new
  course.name     = params.fetch("name")
  course.duration = params.fetch("duration")
  if course.values.any?(&:nil?)
    erb :course_form, locals: {course: course}
  else
    course_list << course
    redirect to("/")
  end
end
```

### deal with error

```ruby
Course = Struct.new(:name, :duration) do
  def duration=(new_duration)
    unless self[:duration] = Duration(new_duration)
      self[:duration] = new_duration
      errors[:duration] = "Unrecognized duration"
    end
  end
 
  def errors
    (@errors ||= {})
  end
end
```


```ruby
template :course_form do
  <<~EOF
  <h1>Add a course</h1>
  <form action="/" method="POST">
    <% course.errors.each do |field, problem| %>
      <div class="toast toast-danger"><%= field %>: <%= problem %></div>
    <% end %>
    <div class="form-group">
      <label class="form-label" for="name">Name</label>
      <input class="form-input" type="text" name="name"
             value="<%= course.name %>"/>
    </div>
    <div class="form-group<%= course.errors[:duration] && ' has-danger' %>">
      <label class="form-label" for="duration">Duration</label>
      <input class="form-input" type="text" name="duration"
             value="<%= course.duration %>"/>
    </div>
    <div class="form-group">
      <input class="btn btn-primary" name="Create" type="submit"/>
    </div>
  </form>
  EOF
end
```


```ruby
 
post "/" do
  course = Course.new
  course.name     = params.fetch("name")
  course.duration = params.fetch("duration")
  if course.errors.any?
    erb :course_form, locals: {course: course}
  else
    course_list << course
    redirect to("/")
  end
end
```
  
And in the process, we’ve introduced a code smell. It’s what I think of as the parallel hierarchy smell. The book Refactoring by Martin Fowler talks about a parallel inheritance hierarchy smell. But it’s possible to have other kinds of parallel hierarchies that are equally smelly.

For every field in this model, there is now, potentially, also an entry in the errors list. This smell is a red flag, telling us that we’re forcing the model object to manage information on behalf of its collaborators. Information that, perhaps, would be better off pushed down into the field values.

Parallel hierarchies introduce new kinds of coupling into our code. Like a child that’s too young to be left alone without its parent, now our field values cannot be left alone without their parent model object. They don’t have complete information on their own.
 
