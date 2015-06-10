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

  el.datepicker({
	  changeMonth: true,
	  changeYear: true,
	  dateFormat: 'mm/dd/yy',
	  altFormat: 'yy-mm-dd',
	  altField: otherFieldSelector,
	  yearRange: yearMin + ":" + yearMax,
          onSelect: function(dateText, dpInstance) {
	    $(this).datepicker("hide");
      $(this).trigger('change');
	  }
  });
  el.datepicker("refresh");
}
```
