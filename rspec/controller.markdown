## rspec for routing


### set instance variable while controller rspec test

```ruby
controller.instance_variable_get("@my_var")
controller.instance_variable_set("@my_var", value)
#you can use my_object.instance_variable_get("@my_var") and my_object.instance_variable_set("@my_var", value) to manipulate the variable.
```




### action controller cache and clear


```ruby
caches_action :index, :cache_path => Proc.new { |c| c.params.delete_if { |k,v| k == 'commit'} }, :expires_in => 300

cache_path => Proc.new { |c| c.params.delete_if { |k,v| k.starts_with?('utm_') } }

```

this may bring trouble while running rspec

```ruby

Rails.cache.clear

```


### with params 

```ruby
get :show, :id => subcategory.id.to_s, :sort => 'title'
```


#### rspec for engine routing

```ruby

require "spec_helper"

describe "routes for Widgets" do
before(:each) { @routes = Project::Engine.routes }
  it "routes /widgets to the widgets controller" do
    get("/widgets").
      should route_to("widgets#index")
  end
end
```

#### normal routing


```ruby

require "spec_helper"

describe "routes for Widgets" do
  it "routes /widgets/foo to the /foo action" do
    { :get => "/widgets/foo" }.
      should route_to(:controller => "widgets", :action => "foo")
  end
end



{ :get => "/articles/2012/11/when-to-use-routing-specs" }.
  should route_to(
    :controller => "articles",
    :month => "2012-11",
    :slug => "when-to-use-routing-specs"
  )

```



## rspec for controller




#### mock with parameter

[mock reference](http://old.rspec.info/documentation/mocks/message_expectations.html)


```ruby
my_mock.should_receive(:msg).with(a, an_instance_of(Fixnum), "b")
```


#### format json

```ruby
describe ApplicationsController do
  render_views
  disconnect_sunspot

  let(:application) { Factory.create(:application) }

  subject { application }

  context "JSON" do

    describe "creating a new application" do

      context "when not authorized" do
        it "should not allow creation of an application" do
          json = { :format => 'json', :application => { :name => "foo", :description => "bar" } }
          post :create, json
          Application.count.should == 0
          response.status.should eq(403)
          JSON.parse(response.body)["status"] == "error"
          JSON.parse(response.body)["message"] =~ /authorized/
        end 


      end 

      context "authorized" do
      end 
    end
  end
end
```


#### format json II

```ruby
# api/v1/test_controller_spec.rb
require 'spec_helper.rb'
describe Api::V1::TestController do
  render_views
  context "when request sets accept => application/json" do
    it "should return successful response" do
      request.accept = "application/json"
      get :test
      response.should be_success
    end
  end
end
```


#### controller mock

```ruby

my_mock.should_receive(:msg).twice

my_mock.should_receive(:msg).exactly(n).times

```


#### basic example

```ruby
describe TeamsController do
  describe "GET index" do
    it "assigns @teams" do
      team = Team.create
      get :index
      expect(assigns(:teams)).to eq([team])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end


```


#### controller with parameter


```ruby
#Unless you mean to pass params[:params][:sort]
get :show, {:id => subcategory.id.to_s, :params => {:sort => 'title'}}
#Should be

get :show, :id => subcategory.id.to_s, :sort => 'title'

controller.params[:sort].should_not be_nil
controller.params[:sort].should eql 'title'


describe "post_event" do

  it "should respond with 204" do
    params = {}
    params['attachment_id'] = @attachment.uid
    params['software_id'] = @license.id
    params['event'] = 'some/event'

    post :post_event, params

    response.code.should eq "204"
  end
end
```


[reference](http://rubydoc.info/gems/rspec-rails/frames)


https://speakerdeck.com/skmetz/magic-tricks-of-testing-railsconf

