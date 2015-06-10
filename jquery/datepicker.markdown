http://formvalidation.io/examples/jquery-ui-datepicker/

http://jqueryui.com/datepicker/#option-dateFormat


datepicker validation


```javascript
$( "#datepicker" ).datepicker({
    onClose: function(dateText, inst) { 
      setTimeout(function(){
        $("#time").focus();
      }, 200);
    }
});
```
