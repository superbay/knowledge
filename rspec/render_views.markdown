## render_views vs render_template

By default, controller specs do not render views. This allows you specify
which view template an action should try to render regardless of whether or
not the template compiles cleanly.


```ruby
require "spec_helper"

describe WidgetsController do
  describe "index" do
    it "renders the index template" do
      get :index
      response.should render_template("index")
      response.body.should == ""
    end
    it "renders the widgets/index template" do
      get :index
      response.should render_template("widgets/index")
      response.body.should == ""
    end
  end
end
```
