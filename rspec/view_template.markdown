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
