### turbolinks


```javascript
function initialize() {
  $('#alert_resolved').click(clickAlert);
}

$(document).ready(initialize);
$(document).on('page:load', initialize);

```



```

<div id="navigation" data-no-turbolink="true">
 <%= link_to 'Show', @request %> |
 <%= link_to 'Back', requests_path %>
</div>
```


