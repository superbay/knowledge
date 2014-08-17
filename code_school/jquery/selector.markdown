### direct descendant


```javascript

$('ul > li');

$('ul').childrent('li');
```


```javascript

$('ul>')

```


### append before after prepend


```javascript
var price = $("<p>Price: 399</p>")
$("ul").before(price);

$("ul").prepend(price);

price.appendTo($("ul"));
//same as prependTo insertAfter insertBefore

```


### closet vs parent


```html
<div class="wrapper">
  <div class="inner">
    <p>Testing <span>1 2 3</span></p>
  </div>
</div>

```

If we hook click on the span, this is what we get back from the three relevant methods:
```javascript
$(this).parent('div') - Empty jQuery object, the parent of the span is not a div.
$(this).parents('div') - jQuery object with two divs in it, the "inner" and "wrapper" divs (in that order).
$(this).closest('div') - jQuery object with one div in it, the "inner" one.

```

Here's the result if we hook click on the span and use span as the selector:
```javascript
$(this).parent('span') - Empty jQuery object, the parent of the span is not a span.
$(this).parents('span') - Empty jQuery object, the span has no ancestor spans.
$(this).closest('span') - jQuery object with the span that was clicked.

```
