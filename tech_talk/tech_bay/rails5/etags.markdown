## 3 minutes rails 5


### Rails 5 switches from strong etags to weak etags

ETag, short for entity tag, is a part of HTTP header and is used for web cache validation. ETag is a digest of the resource that uniquely identifies specific version of the resource. This helps browser and web servers determine if resource in the browser’s cache is exactly same as the resource on the server.

Strong v/s Weak ETags

ETag supports [strong and weak validation](strong and weak validation ) of the resource.

Strong ETag indicates that resource content is same for response body and the response headers.

Weak ETag indicates that the two representations are semantically equivalent. It compares only the response body.

Weak ETags are prefixed with W\ and thus one can easily distinguish between Weak ETags and Strong ETags.

```
"543b39c23d8d34c232b457297d38ad99"    – Strong ETag
W/"543b39c23d8d34c232b457297d38ad99"  – Weak ETag
```

W3 has an example page to illustrate how ETag matching works.

When server receives a request, it returns an ETag header as part of HTTP response. This ETag represents state of the resource. For the subsequent HTTP requests, client sends this ETag via If-None-Match header to identify if the resource is changed or not. The server will compare the current ETag and the one sent by the client. If ETag matches, server responds with 304 Not modified. This means resource content in the client’s cache is uptodate. If resource is changed, server will send updated resource along with the new ETag.

Let’s see it in action.

