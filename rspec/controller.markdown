## rspec for controller

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


