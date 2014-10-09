http://makandracards.com/makandra/1076-mocks-and-stubs-in-test-unit-when-you-are-used-to-rspec


I have some Ruby on Rails controllers that depend on checking a custom HTTP header value, which I wanted to test. In integration tests, you can pass a hash of headers when you call your request method:

```ruby
post(:create, {:something => {:name => "foo"}}, {"CUSTOM_HEADER" => "bar"})
```

But in functional tests, you set custom headers on the @request object:

```ruby
@request.env["Referer"] = "bar"
post(:create, {:something => {:name => "foo"}})
```

Why this isn’t handled consistently, I don’t know, but I had some trouble tracking it down as it’s not documented in the API docs for ActionController::TestCase.
