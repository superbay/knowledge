### authentication

controller need header authorize

```ruby
    class ProductsController < ApplicationController
      before_filter :restrict_access
      respond_to :json

      # Actions omitted

      private
      def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
      end
    end
```


or 


```ruby

def restrict_access
  authenticate_or_request_with_http_token do |token, options|
    ApiKey.exists?(access_token: token)
  end
end

```

local test:


```bash
$ curl http://localhost:3000/api/products -H 'Authorization: Token token="afbadb4ff8485c0adcba486b4ca90cc4"'
```
