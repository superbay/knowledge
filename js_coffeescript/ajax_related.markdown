



### preventDefault


```html


<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>event.preventDefault demo</title>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
 
<a href="http://jquery.com">default click action is prevented</a>
<div id="log"></div>
 
<script>
$( "a" ).click(function( event ) {
  event.preventDefault();
  $( "<div>" )
    .append( "default " + event.type + " prevented" )
    .appendTo( "#log" );
});
</script>
 
</body>
</html>

```
