

the way to mock

```ruby
#mock params pass to that view
controller.request.path_parameters[:some_param] = 'a value'
```

If its a controller test then it would be
```ruby
controller.stub!(:params).and_return {}
```

If its a helper test then it would be:

```ruby
helper.stub!(:params).and_return {}
```

And its a view test it would be:

```ruby
view.stub!(:params).and_return {}
```

```ruby

require 'spec_helper'
describe "api/v1/users/create.json.jbuilder" do

    let( :user )    { User.create( :not_strict => true ) }

    it "renders first_name" do
        render :template => "api/v1/users/create", :locals => { :user => user }, :formats => :json, :handler => :jbuilder
        rendered.should have_json_node( :first_name ).with( user.first_name )
    end
end

```


### stub local variable


```ruby
before(:each) do
  view.stub(:current_user) { User.new }
  
  view.stub(:current_user).and_return(@user)
end
```


```ruby
before :each do
  @user = stub_model(User, is_welcome: true)
  assign(:current_user, @user)
end
Then to test the conditionality, just ran another spec in a context with a different before block:

before :each do
  @user = stub_model(User, is_welcome: false)
  assign(:current_user, @user)
end
```

### Isolating partials

```ruby
before do
  stub(view).render 'partial/1'
  stub(view).render 'partial/2' # etc, one stub for each partial
  stub.proxy(view).render       # let the main "render" call through
end


# in view
render 'foo/bar', :thing => '2', :other_thing => 'bar'

# in spec
stub(view).render 'foo/bar', :thing => '2', :other_thing => 'bar'


render
view.should render_template(:partial => 'foo', :local1 => 'bar', :local2 => 'baz')
```



```ruby
#For partials with locals, the render call should resemble:

render 'shared/errors', :model => model
#
This is equivalent to the more verbose:

render :partial => 'shared/errors', :locals => { :model => model }
```


### controller

```ruby
describe TestController do
  it "test some_method"
    phone = Phone.new(...)
    controller.stub(:some_method).and_return(true)
    controller.send(:some_method).should be_true
  end
end
```


[email spec](https://github.com/bmabey/email-spec)
