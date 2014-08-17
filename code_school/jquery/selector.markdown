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
