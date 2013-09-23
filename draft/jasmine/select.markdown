### test select method

```javascript
  describe('.initStyle', function() {
    it('intial the annotation style and pin style', function() {
      loadFixtures('annotation.html');
      var annotation_container = $('.annotation_container');
      var image_menu = $('.image_menu');
      BLOOMBERG.bw_image.initStyle(annotation_container, image_menu);
      $('.pin_style_select option[value=icons-blue_pin]').attr('selected', 'selected');
      $('.pin_style_select').change();
      expect(annotation_container.attr('data-pin_icon')).toEqual('icons-blue_pin');
      expect($('.pin').attr('class')).toContain('icons-blue_pin');
    });
  });
```

#### hints

[origin jasmine link](https://github.com/pivotal/jasmine) <br/>
[feature of fixture](https://github.com/velesin/jasmine-jquery)
