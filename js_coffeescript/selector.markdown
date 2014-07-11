## comma



```javascript
jQuery("tr","#ctl00_MainContent_MyUserControl").each(function(i,row) { ... }
```

It looks like it's selecting <tr>'s from the user control on the page (ignore the fact that the instance is fully named!)
but it's not a syntax I'm familiar with and can't find anything in the documentation. I'd expect it to be written:

```javacript
$("#ctl00_MainContent_MyUserControl tr").each(function(i,row) { ... }
```
