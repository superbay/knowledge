## Rack and Rails

![screen shot 2013-10-03 at 9 40 29 pm](https://f.cloud.github.com/assets/83296/1266773/0f2cd5ba-2c96-11e3-8309-7ec8bc909d63.png)


### What's Rack

> a Ruby Webserver Interface

> Rack provides a minimal interface between webservers supporting Ruby and Ruby frameworks.

-- Offical Rack Website

> Rack provides a minimal, modular and adaptable interface for developing web applications in Ruby. By wrapping HTTP requests and responses in the simplest way possible, it unifies and distills the API for web servers, web frameworks, and software in between (the so-called middleware) into a single method call.

### Basic Rack

```ruby
class JSONServer
  def call(env)
    [200, {"Content-Type" => "application/json"}, ['{ "message" : "Hello!" }']]
  end
end

map '/hello.json' do
  run JSONServer.new
end
```

```ruby
curl http://localhost:9292/hello.json
{ message: "Hello!" }

```

### Contributed Rack Middleware and Utilities

This package includes a variety of add-on components for Rack, a Ruby web server
interface:

* Rack::JSONP - Adds JSON-P support by stripping out the callback param
  and padding the response with the appropriate callback format.
* Rack::LighttpdScriptNameFix - Fixes how lighttpd sets the SCRIPT_NAME
  and PATH_INFO variables in certain configurations.
* Rack::Locale - Detects the client locale using the Accept-Language request
  header and sets a rack.locale variable in the environment.
* Rack::MailExceptions - Rescues exceptions raised from the app and
  sends a useful email with the exception, stacktrace, and contents of the
  environment.
* Rack::NestedParams - parses form params with subscripts (e.g., * "post[title]=Hello")
  into a nested/recursive Hash structure (based on Rails' implementation).
* Rack::PostBodyContentTypeParser - Adds support for JSON request bodies. The
  Rack parameter hash is populated by deserializing the JSON data provided in
  the request body when the Content-Type is application/json.
* Rack::ProcTitle - Displays request information in process title ($0) for
  monitoring/inspection with ps(1).
* Rack::Profiler - Uses ruby-prof to measure request time.
* Rack::Sendfile - Enables X-Sendfile support for bodies that can be served
  from file.
* Rack::Signals - Installs signal handlers that are safely processed after
  a request
* Rack::StaticCache - Modifies the response headers to facilitiate client and proxy caching for
  static files that minimizes http requests and improves overall load times for second time visitors.
* Rack::TimeZone - Detects the client's timezone using JavaScript and sets
  a variable in Rack's environment with the offset from UTC.
* Rack::Evil - Lets the rack application return a response to the client from any place.
* Rack::Callbacks - Implements DSL for pure before/after filter like Middlewares.
* Rack::Config - Shared configuration for cooperative middleware.
* Rack::NotFound - A default 404 application.
* Rack::CSSHTTPRequest - Adds CSSHTTPRequest support by encoding responses as
  CSS for cross-site AJAX-style data loading
* Rack::Deflect - Helps protect against DoS attacks.
* Rack::ResponseCache - Caches responses to requests without query strings
  to Disk or a user provider Ruby object. Similar to Rails' page caching.
* Rack::RelativeRedirect - Transforms relative paths in redirects to
  absolute URLs.
* Rack::Backstage - Returns content of specified file if it exists, which makes
  it convenient for putting up maintenance pages.
* Rack::AcceptFormat - Adds a format extension at the end of the URI when there is none, corresponding to the mime-type given in the Accept HTTP header.
* Rack::HostMeta - Configures /host-meta using a block
* Rack::Cookies - Adds simple cookie jar hash to env
* Rack::Access - Limits access based on IP address
* Rack::ResponseHeaders - Manipulates response headers object at runtime
* Rack::SimpleEndpoint - Creates simple endpoints with routing rules, similar to Sinatra actions
* Rack::TryStatic - Tries to match request to a static file
* Rack::Printout - Prints the environment and the response per request

#### How to Use

Git is the quickest way to the rack-contrib sources:
```
  git clone git://github.com/rack/rack-contrib.git
```
Gems are available too:
```
  gem install rack-contrib
```
Requiring 'rack/contrib' will add autoloads to the Rack modules for all of the
components included. The following example shows what a simple rackup
(+config.ru+) file might look like:

```ruby
  require 'rack'
  require 'rack/contrib'

  use Rack::Profiler if ENV['RACK_ENV'] == 'development'

  use Rack::ETag
  use Rack::MailExceptions

  run theapp
```

#### Resource

1. http://southdesign.de/blog/rack.html
2. [Official Rack Website](http://rack.github.io/) 
3. [Rack Contrib](https://github.com/rack/rack-contrib)
4. [Rails Guides](http://guides.rubyonrails.org/rails_on_rack.html)
