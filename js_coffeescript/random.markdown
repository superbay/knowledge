#### random number

```javascript
$(document).ready(function(){
    var randomNum = Math.ceil(Math.random()*2); /* Pick random number between 1 and 2 */
    $("body").css({'background' : 'url(images/main' + randomNum + '.jpg)'});
});
```
