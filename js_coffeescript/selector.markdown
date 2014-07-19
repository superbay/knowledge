## comma



```javascript
jQuery("tr","#ctl00_MainContent_MyUserControl").each(function(i,row) { ... }
```

It looks like it's selecting <tr>'s from the user control on the page (ignore the fact that the instance is fully named!)
but it's not a syntax I'm familiar with and can't find anything in the documentation. I'd expect it to be written:

```javascript
$("#ctl00_MainContent_MyUserControl tr").each(function(i,row) { ... }
```


### find parents with particular element


```javascript

 jQuery(this).parents('.refine')

```


### selected options

```javascript

$('select[name="thegivenname"] option:selected').val();

```



Try this with [attribute-starts-with-selector](http://api.jquery.com/attribute-starts-with-selector)

```javascript
$('select[id^="begin"]').each(function () {
    console.log(this.id);
});

```
or you could use [attribute-ends-with-selector](http://api.jquery.com/attribute-ends-with-selector)

```javascript
$('select[id$="end"]').each(function () {
    console.log(this.id);
});

```

To select the first 3 you can use :lt(3) like this

```javascript
$('select[id^="begin"]:lt(3)').each(function () {
    console.log(this.id);
});
```

[DEMO](http://jsfiddle.net/Alfie/jZN8D)


To combine the selectors you can do this

```javascript
$('select[id^="begin"][id$="end"]').each(function () {
    console.log(this.id);
});

```

[DEMO](http://jsfiddle.net/Alfie/3zwcj/1/)

If you want to select an element with id that starts with begin OR end you can do this using , to get two different selectors

```javascript
$('select[id^="begin"],select[id$="end"]').each(function () {
    //                ^
    console.log(this.id);
});
```

```javascript

$( "input[name!='newsletter']" ).next().append( "<b>; not newsletter</b>" );

```



```html

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>not demo</title>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
 
<div>
  <input type="checkbox" name="a">
  <span>Mary</span>
</div>
<div>
  <input type="checkbox" name="b">
  <span>lcm</span>
</div>
<div>
  <input type="checkbox" name="c" checked="checked">
  <span>Peter</span>
</div>
 
<script>
$( "input:not(:checked) + span" ).css( "background-color", "yellow" );
$( "input").attr( "disabled", "disabled" );
</script>
 
</body>
</html>
```


[DEMO](http://jsfiddle.net/Alfie/3zwcj/2/)




![screen shot 2014-07-11 at 1 49 10 pm](https://cloud.githubusercontent.com/assets/83296/3556416/bccba592-0923-11e4-9dff-3396af0bdf6d.png)
