```javascript
    $('#edit_mode').bind('click',function(e){
        e.preventDefault();
        $(this).toggleClass('ticked');
    });   
```


#### get and change select

```javascript
(function () {
    var previous;

    $("select").focus(function () {
        // Store the current value on focus and on change
        previous = this.value;
    }).change(function() {
        // Do something with the previous value after the change
        alert(previous);

        // Make sure the previous value is updated
        previous = this.value;
    });
})();
```

```javascript

$(document).ready(function(){
  var sel = $("#sel");
  sel.data("prev",sel.val());

  sel.change(function(data){
     var jqThis = $(this);
     alert(jqThis.data("prev"));
     jqThis.data("prev",jqThis.val());
  });
});
```

```javascript

//set the pre data, usually needed after you initialize the select element
$('mySelect').data('pre', $(this).val());

$('mySelect').change(function(e){
    var before_change = $(this).data('pre');//get the pre data
    //Do your work here
    $(this).data('pre', $(this).val());//update the pre data
})

```
