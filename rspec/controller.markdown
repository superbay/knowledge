## rspec for controller


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
```


[reference](http://rubydoc.info/gems/rspec-rails/frames)


