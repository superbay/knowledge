### google host cdn


```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<!-- last version support IE8.0 -->
<script src="http://code.jquery.com/jquery-1.9.0.js"></script>

<script src="http://code.jquery.com/jquery-2.0.3.js"></script>
```
[google libraries list](https://developers.google.com/speed/libraries/devguide#jquery)

[jquery cdn list](http://code.jquery.com/)

#### button_to with additonal parameter

```ruby
$('form').append('<input type="button" value="test" />');
```


### ready



```ruby
jQuery( document ).ready(function( $ ) {
  // Code using $ as usual goes here.
});


$( document ).ready(function() {
  // Handler for .ready() called.
});
```


### parse to get table


```javascript

$('#similar_errors td:contains("bmmr_id") a').each(function(i,value){ console.log($(value).text()); })
```
