### Google Map api





google_map


### Custom markers

https://developers.google.com/maps/tutorials/customizing/custom-markers
https://developers.google.com/maps/documentation/javascript/markers

```javascript
var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
var icons = {
  parking: {
    icon: iconBase + 'parking_lot_maps.png'
  },
  library: {
    icon: iconBase + 'library_maps.png'
  },
  info: {
    icon: iconBase + 'info-i_maps.png'
  }
};

function addMarker(feature) {
  var marker = new google.maps.Marker({
    position: feature.position,
    icon: icons[feature.type].icon,
    map: map
  });
}
```

### good icon for custom markers

http://www.iconarchive.com/show/vista-map-markers-icons-by-icons-land/Map-Marker-Bubble-Pink-icon.html



```ruby


```
