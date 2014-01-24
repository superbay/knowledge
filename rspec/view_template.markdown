
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
