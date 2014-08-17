## Controller

#### send_file
```ruby
send_file '/path/to.jpg', type: 'image/jpeg', disposition: 'inline'
```


#### send_data

```ruby
require 'RMagick'

class CaptchaController < ApplicationController

  def image
    # create an RMagic canvas and render difficult to read text on it
    img = canvas.flatten_images
    img.format = "JPG"

    # send it to the browser
    send_data img.to_blob, disposition: 'inline', type: 'image/jpg'
  end
end

```

```ruby
class StreamingController < ApplicationController include ActionController::Live
  # Streams about 180 MB of generated data to the browser.
  def stream 
    10_000_000.times do |i|
      response.stream.write "This is line #{i}\n"
    end
  ensure
    response.stream.close 
  end
end
```


```ruby
render inline: "%span.foo#{@foo.name}", type: "haml"
render text: 'Submission accepted',content_type: 'text/plain'
render json: @projects, include: :tasks
render json: @record, callback: 'update Records Display'
render nothing: true, status: 401
```

#### redirect_to

```ruby
redirect_to "http://www.rubyonrails.org"
redirect_to post_url(@post),status: :found
redirect_to :atom, status: :moved_permanently
redirect_to post_url(@post), status: 301
redirect_to :atom, status: 302
```

#### Flash message

New to Rails 4, is the ability to register your own flash types by using the newActionController::Flash.add_- flash_types macro style method.

```ruby
classApplicationController
  ...
  add_flash_types :error
end
```

An action callback can take one of three forms: method reference (symbol), external class, or block.
```ruby
#external class
class OutputCompressionActionCallback 
  def self.after(controller)
    controller.response.body = compress(controller.response.body) 
  end
end

class NewspaperController < ActionController::Base
  after_action OutputCompressionActionCallback
end
```
inline method
```ruby
class WeblogController < ActionController::Base
  before_action do
    redirect_to new_user_session_path unless authenticated? 
  end
end
```

before filter chain order

```ruby
class ShoppingController < ActionController::Base 
  before_action :verify_open_shop
end

class CheckoutController < ShoppingController
  prepend_before_action :ensure_items_in_cart, :ensure_items_in_stock
end
```
excute sequence: :ensure_items_in_cart, :ensure_items_in_- stock, :verify_open_shop

#### Rack

```ruby
class HelloWorld
  def call(env)
   [200, {"Content-Type" => "text/plain"}, ["Hello world!"]]
  end
end
```

#### MiddleWare

```ruby
#application.rb
module Example
  class Application < Rails::Application
    ...
    # Rack::ShowStatus catches all empty responses the app it wraps and 
    # replaces them with a site explaining the error. 
    config.middleware.use Rack::ShowStatus
  end 
end

```
