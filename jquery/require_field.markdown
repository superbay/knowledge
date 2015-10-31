### HTML5 form required attribute. Set custom validation message?

```html
<form id="myform">
    <input id="email" oninvalid="InvalidMsg(this);" name="email" oninput="InvalidMsg(this);"  type="email" required="required" />
    <input type="submit" />
</form>
```



```javascript
function InvalidMsg(textbox) {
    if (textbox.value == '') {
        textbox.setCustomValidity('Required email address');
    }
    else if (textbox.validity.typeMismatch){{
        textbox.setCustomValidity('please enter a valid email address');
    }
    else {
       textbox.setCustomValidity('');
    }
    return true;
}

```
