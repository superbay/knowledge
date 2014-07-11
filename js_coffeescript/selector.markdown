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


![screen shot 2014-07-11 at 1 49 10 pm](https://cloud.githubusercontent.com/assets/83296/3556416/bccba592-0923-11e4-9dff-3396af0bdf6d.png)
