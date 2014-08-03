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


http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Outside-Chartreuse-icon.png

http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Outside-Pink-icon.png

http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Outside-Azure-icon.png


### other group

http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Inside-Pink-icon.png

http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Inside-Azure-icon.png

http://icons.iconarchive.com/icons/icons-land/vista-map-markers/24/Map-Marker-Marker-Inside-Chartreuse-icon.png


```ruby


```
