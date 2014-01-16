### Step 1: HTML markup

The first thing we do is get acquainted with the basic HTML markup for this project. As I mentioned before this is a common HTML structure. We have a page container and content inside. The only thing that might be odd is that the footer is below and not inside the page container. This is important. Other than that it’s pretty straightforward:

```html
<div id="container">
 <div id="content"></div>
</div>
<div id="footer">My Sticky Footer</div>
```

### Step 2: “body stretching”

Secondly, stretch html, body and page container elements to full window height. Notice that to make page container inherit body overflow I am using min-height property. Since IE6 or earlier does not support this, we have to make sure that IE, but only IE, applies height property to fix it. Here’s the right way to do it:

```css
html, body, #container { height: 100%; }
body > #container { height: auto; min-height: 100%; }
```

### Step 3: positioning the footer

Thirdly, we have to place the footer right after page container, creating a body overflow. However, we want it to be visible, so we forcibly move it up overlapping the bottom of page container — negative top margin for that reason. To make sure the whole footer is visible, negative margin must be equal to defined footer height. To fully secure footer’s position let’s clear both sides of floating elements, just in case.

```css
#footer {
 clear: both;
 position: relative;
 z-index: 10;
 height: 3em;
 margin-top: -3em;
}
```

### Step 4: finishing touches

Finally, we have to protect page content bottom from finding itself behind the footer by doing this:

```css
#content { padding-bottom: 3em; }
```

Note that padding value is equal to footer height.
