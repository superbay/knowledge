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


### append vs prepend


suppose:
```html
<div class='a'> //<---you want div c to append in this
  <div class='b'>b</div>
</div>
```


when .append() executes it will look like this:


```javascript
$('.a').append($('.c'));
```

after execution:

```html
<div class='a'> //<---you want div c to append in this
  <div class='b'>b</div>
  <div class='c'>c</div>
</div>
```

when .prepend() executes it will look like this:

```javacript
$('.a').prepend($('.c'));
```

after execution:

```html
<div class='a'> //<---you want div c to append in this
  <div class='c'>c</div>
  <div class='b'>b</div>
</div>
```
.prepend() in execution.


### after vs before


.after() puts the element after the element
.before() puts the element before the element


using after:

```javascript
$('.a').after($('.c'));
```

after execution:

```html
<div class='a'>
  <div class='b'>b</div>
</div>
<div class='c'>c</div> //<----this will be placed here
```

Fiddle with .after() in execution.

using before:

```javascript
$('.a').before($('.c'));
```

after execution:

```html
<div class='c'>c</div> //<----this will be placed here
<div class='a'>
  <div class='b'>b</div>
</div>
```

