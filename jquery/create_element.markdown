```
$('<div />', {
        "class": 'test',
        text: "a div",
        click: function(e){
            e.preventDefault();
            alert("test")
        }})
```



```html
<html>
<head>
<title>JavaScript about:blank context</title>
<script src="http://code.jquery.com/jquery-1.9.0.js"></script>

<script type="text/javascript">

jQuery( document ).ready(function( $ ) {
  // Code using $ as usual goes here.
  function doSomething() {
    //var matchingOfferings = $('#matchingOfferings')//document.getElementById("matchingOfferings");//change ID
    var container = $('#presentSearchResult')//document.getElementById("presentSearchResult");
    var opt_cat1 = $('#optCat1') //document.getElementById("optCat1");

    $('#matchingOfferings option').each(function( index ){
      if( this.value ) {
        d = $("<div />", {
          style : "width:220px;padding:10px;border:5px solid gray;margin:0px;"
        });
        var some = this.value;

        $("<a />", {
          title : this.value,
          href : "#",
          text : this.value
        }).click(function() {
          $('#optCat1').val(some);
          container.empty();
        }).appendTo(d);

        $("<div />", {
          text : this.label
        }).appendTo(d);

        $(d).appendTo(container);
        container.append('<br />');
      }
    });

  };

  $('.link').click(function(){
     doSomething();
  });


});
 
</script>
</head>
<body>
  <div id="availableSelections">
    <select id="matchingOfferings">
      <option value="Test 1">Something about Test 1</option>
      <option value="Test 2">Something about Test 2</option>
      <option value="Test 3">Something about Test 3</option>
      <option value="Test 4">Something about Test 4</option>
    </select>
  </div>
  <div id="presentSearchResult">
  </div>
  <div id="setOptCatValue">
    <button class="link">Test IT</button>
    <br/>
    <input type="text" id="optCat1" />
  </div>
</body>
</html>
```
