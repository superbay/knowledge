



```javascript
function rid_fakes() {
       var ids = [];
       db.authors.find().forEach( function(obj) {
           if (db.books.find({author_id: obj._id }).length() == 0 ) {
             ids.push(obj._id);
           }
});
       db.authors.remove({_id : { $in : ids }});
   }
db.eval(rid_fakes);

```
