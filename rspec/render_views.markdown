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

so render_views means you do want to test view in your controller

```ruby
require "spec_helper"

describe WidgetsController do
  render_views

  describe "GET index" do
    it "says 'Listing widgets'" do
      get :index
      expect(response.body).to match /Listing widgets/m
    end
  end
end
```



```ruby

require "spec_helper"

describe WidgetsController do
  context "with render_views" do
    render_views

    describe "GET index" do
      it "renders the actual template" do
        get :index
        expect(response.body).to match /Listing widgets/m
      end
    end

    context "with render_views(false) nested in a group with render_views" do
      render_views false

      describe "GET index" do
        it "renders the RSpec generated template" do
          get :index
          expect(response.body).to eq("")
        end
      end
    end
  end

  context "without render_views" do
    describe "GET index" do
      it "renders the RSpec generated template" do
        get :index
        expect(response.body).to eq("")
      end
    end
  end

  context "with render_views again" do
    render_views

    describe "GET index" do
      it "renders the actual template" do
        get :index
        expect(response.body).to match /Listing widgets/m
      end
    end
  end
end

```
