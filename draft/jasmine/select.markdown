### test select method

```javascript
  describe('.initStyle', function() {
    it('intial the annotation style and pin style', function() {
      loadFixtures('annotation.html');
      var annotation_container = $('.annotation_container');
      var image_menu = $('.image_menu');
      BBG.bw_image.initStyle(annotation_container, image_menu);
      $('.pin_style_select option[value=icons-blue_pin]').attr('selected', 'selected');
      $('.pin_style_select').change();
      expect(annotation_container.attr('data-pin_icon')).toEqual('icons-blue_pin');
      expect($('.pin').attr('class')).toContain('icons-blue_pin');
    });
  });
```


#### function

```javascript
  bw_image.initStyle = function(annotation_container, image_menu) {
      var annotation_style_select = image_menu.find('.annotation_style_select');
      var pin_style_select = image_menu.find('.pin_style_select'); 
      annotation_style_select.val(annotation_container.data('skin'));
      var all_annotation_style = 'light-opaque light-transparent dark-opaque dark-transparent'; 
      annotation_style_select.bind('change', function(){
          annotation_container.removeClass(all_annotation_style).addClass(this.value).attr('data-skin', this.value);
      });

      var all_pin_style = 'icons-blue_pin icons-red_pin'; 
      if (annotation_container.length != 0) {
        pin_style_select.val(annotation_container.data('pin_icon'));
      } else {
        //default pin style to red_pin
        pin_style_select.val('icons-red_pin');
      }

      pin_style_select.bind('change', function(){
          $('.pin').removeClass(all_pin_style).addClass(this.value);
          annotation_container.attr('data-pin_icon', this.value);
      });
  };
```

#### fixture

```html
<!--spec/javascripts/fixtures/annotation.html-->
<div class='annotation_container' data-skin='light-transparent' data-pin_icon='icons-red_pin'>
</div>

<div class='image_menu'>
  <select class='annotation_style_select'>
    <option>light-transparent</option>
  </select>
  <select class='pin_style_select'>
    <option value='icons-red_pin'>Red</option>
    <option value='icons-blue_pin'>Blue</option>
  </select>
</div>

<div class='pin'>

</div>
```

#### hints

[origin jasmine link](https://github.com/pivotal/jasmine) <br/>
[feature of fixture](https://github.com/velesin/jasmine-jquery)
