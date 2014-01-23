### Change the mouse cursor on mouser over to anchor-like style


Assuming your div has an id="myDiv", add the following to your CSS. The cursor: pointer specifies that the cursor should be the same hand icon that is use for anchors (hyperlinks):

CSS to Add
```css
#myDiv
{
    cursor: pointer;
}
```

You can simply add the cursor style to your div's HTML like this:

```html
<div style="cursor: pointer">
</div>

```


If you are determined to use jQuery for this, then add the following line to your $(document).ready() or body onload: (replace myClass with whatever class all of your divs share)

```javascript
$('.myClass').css('cursor', 'pointer');
```
