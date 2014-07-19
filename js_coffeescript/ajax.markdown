### example of ajax


```coffeescript

$ ?= require 'jquery' # For Node.js compatibility

$(document).ready ->
    # Basic Examples
    $.get '/', (data) ->
        $('body').append "Successfully got the page."

    $.post '/',
        userName: 'John Doe'
        favoriteFlavor: 'Mint'
        (data) -> $('body').append "Successfully posted to the page."

    # Advanced Settings
    $.ajax '/',
        type: 'GET'
        dataType: 'html'
        error: (jqXHR, textStatus, errorThrown) ->
            $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
            $('body').append "Successful AJAX call: #{data}"
```

[reference book should read](http://coffeescriptcookbook.com/chapters/jquery/ajax)


```javascript

(document).ready ->
    if $('form').attr('action') == '/cards'
        $('#add_card').click (e) ->
            e.preventDefault()
            $.ajax '/cards',
                type: 'POST'
                dataType: 'json'
                data: { code: $("#code").val() }
                error: (jqXHR, textStatus, errorThrown) ->
                    alert textStatus
                success: (data, textStatus, jqXHR) ->
                    console.log "Card name: " +
                                data.card.code + "\nPoints: " + data.points
```

### data as json

```javascript


$.ajax({
  url: '/create_lead',
  data: {
    name: $('#lead_gen_name').val(),
    'lead_gen[email]': $('#lead_gen_email').val(),  
  },
  type: 'POST',
  dataType: 'json',
  success: function(data) { }
});

```


```javascript

info = {};
info['first'] = 'hi';
info['second'] = 'hello';


$.ajax({
   type: "POST",
   data: {info:info},
   url: "index.php",
   success: function(msg){
     $('.answer').html(msg);
   }
});

```
