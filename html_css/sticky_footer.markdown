### sticky footer

### normal

From IE7, simply use:

```css
#footer {
    position:fixed;
    bottom:0;
}
```

### solution one

```css
#footer {
 clear: both;
 position: relative;
 z-index: 10;
 height: 3em;
 margin-top: -3em;
}

```
[demo](sticky_footer_demo.markdown)
