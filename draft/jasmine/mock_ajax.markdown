### mock or stub ajax 


```javascript
loadFixtures('video_index.html');
var deferred = new jQuery.Deferred();
spyOn($, 'ajax').andCallFake(function(){
    var d = $.Deferred();
    d.resolve('remote back data');
    return d.promise();
});
var number_to_read = $('#more_expected_videos li.for_continue_display').size();
NameSpace.video.play_next_recommended();
expect($.ajax).toHaveBeenCalled();
```
