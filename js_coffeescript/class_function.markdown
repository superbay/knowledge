```ruby
class @CreditCard
  constructor: (number) ->
    @number = number.replace(/[ -]/g, '')

  validNumber: ->
    total = 0
    for i in [(@number.length-1)..0]
      n = +@number[i]
      if (i+@number.length) % 2 == 0
        n = if n*2 > 9 then n*2 - 9 else n*2
      total += n
    total % 10 == 0


$.fn.validateCreditCardNumber = ->
  @each ->
    $(this).blur ->
      card = new CreditCard(@value)
      if !card.validNumber()
        $(this).next('.error').text("Invalid card number.")
      else
        $(this).next('.error').text("")
```


```javascript


this.CreditCard = (function() {

  function CreditCard(number) {
    this.number = number.replace(/[ -]/g, '');
  }

  CreditCard.prototype.validNumber = function() {
    var i, n, total, _i, _ref;
    total = 0;
    for (i = _i = _ref = this.number.length - 1; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
      n = +this.number[i];
      if ((i + this.number.length) % 2 === 0) {
        n = n * 2 > 9 ? n * 2 - 9 : n * 2;
      }
      total += n;
    }
    return total % 10 === 0;
  };

  return CreditCard;

})();

$.fn.validateCreditCardNumber = function() {
  return this.each(function() {
    return $(this).blur(function() {
      var card;
      card = new CreditCard(this.value);
      if (!card.validNumber()) {
        return $(this).next('.error').text("Invalid card number.");
      } else {
        return $(this).next('.error').text("");
      }
    });
  });
};

```
