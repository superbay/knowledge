```javascript
var puzzlers = [
  function(a) { return 3 * a - 8; },
  function(a) { return (a + 2) * (a + 2) * (a + 2); },
  function(a) { return a * a - 9; },
  function(a) { return a % 4; }
];

puzzlers.map( function (func) {
  return func(3);
});
```
