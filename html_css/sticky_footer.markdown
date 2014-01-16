### sticky footer

### normal

From IE7, simply use:

```css
#footer {
    position:fixed;
    bottom:0;
}
```

#### example1

```html
<div id="container">
   <div id="header"></div>
   <div id="body"></div>
   <div id="footer"></div>
</div>
```

```css
html,
body {
   margin:0;
   padding:0;
   height:100%;
}
#container {
   min-height:100%;
   position:relative;
}
#header {
   background:#ff0;
   padding:10px;
}
#body {
   padding:10px;
   padding-bottom:60px;   /* Height of the footer */
}
#footer {
   position:absolute;
   bottom:0;
   width:100%;
   height:60px;   /* Height of the footer */
   background:#6cf;
}
```

example2

```html
<body>
    <header></header>
    <article></article>
    <footer></footer>
</body>
```

```css
html{ height:100%; }
body{ min-height:100%; position:relative; }
body:after{ content:''; display:block; height:100px; }
footer{ 
  position:absolute; 
  bottom:0; 
  width:100%; 
  height:100px; 
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
