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

### get options selected value

```coffeescript
$(document).ready ->
  desk_case_ids = $('desk_case').val()

```

### set options selected for dropdown list

how to select options in Multiple select list with jQuery?

```html
<select name='strings' id="strings" multiple style="width:100px;">
    <option value="Test">Test</option>
    <option value="Prof">Prof</option>
    <option value="Live">Live</option>
    <option value="Off">Off</option>
    <option value="On">On</option>
</select>

```

#### solution:

```
var values = "Test,Prof,Off";
$('#strings').val(values.split(','));

$('#strings option[value=' + objValue + ']').attr('selected', true);

$.each values, (index, value) ->
  $("#desk_labels option[value=" + value + "]").attr("selected", "selected")

```

in jQuery:

```javascript
$("#strings").val(["Test", "Prof", "Off"]);
```


or in pure javascript:


```javascript

document.getElementById('strings').value = ["Test", "Prof", "Off"];
```


### parse to get table


```javascript

$('#similar_errors td:contains("bmmr_id") a').each(function(i,value){ console.log($(value).text().match(/=.*/i).toString().substring(1)); })


$('#similar_errors td:contains("bmmr_id") a').each(function(i,value){ console.log($(value).text().match(/bmmr_id=.*/i).toString()); })
```


### how to validate zip code

```javascript

$('#create_membership').click(function()
{
    var zip = $('#zip').val();

    var zipRegex = /^\d{5}$/;

    if (!zipRegex.test(zip))
    {
        // trigger error
    }
    else
    {
        // success!
    }
});
```



### load jQuery in console

```
var script = document.createElement('script');script.src = "https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js";document.getElementsByTagName('head')[0].appendChild(script);
```

http://stackoverflow.com/questions/7474354/include-jquery-in-the-javascript-console
