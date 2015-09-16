https://jqueryui.com/slider/#rangemax

jquery 2 decimal 
In jQuery, what's the best way of formatting a number to 2 decimal places?

```javascript
$("#number").each(function(){
  $(this).val(parseFloat($(this).val()).toFixed(2));
});
````
