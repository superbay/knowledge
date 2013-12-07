### javasrcipt interview question:

#### How to created instace method

```javascript
//Define a functional object to hold employee in JavaScript
var Employee = function(name) {
    this.name = name;
};

//Add dynamically to the already defined object a new getter
Employee.prototype.getName = function() {
    return this.name;
};

//Create a new object of type Manager by defining its constructor. 
// It's not related to Employee for now.
var Manager = function(name) {
    this.name = name;
};

//Now inherit it from Employee

Manager.prototype = new Employee();     

//Now I can call the methods of Employee on the Manager, let's try,
//first I need to create a Manager.
var myManager = new Manager('John Smith');
myManager.alertMyName();
```

#### How to implement javascript inheritance


```javascript
function Car(name){
    this.Name = name;
}

Car.prototype.Drive = function(){
    document.write("My name is " + this.Name + " and I'm driving. <br />");
}

SuperCar.prototype = new Car();
SuperCar.prototype.constructor = SuperCar;

function SuperCar(name){
    Car.call(this, name);
}

SuperCar.prototype.Fly = function(){
    document.write("My name is " + this.Name + " and I'm flying! <br />");
}

var myCar = new Car("Car");
myCar.Drive();

var mySuperCar = new SuperCar("SuperCar");
mySuperCar.Drive();
mySuperCar.Fly();
Second block:

function Car(name){
    this.Name = name;
    this.Drive = function(){ 
        document.write("My name is " + this.Name + " and I'm driving. <br />");
    }
}

SuperCar.prototype = new Car();

function SuperCar(name){
    Car.call(this, name);
    this.Fly = function(){
        document.write("My name is " + this.Name + " and I'm flying! <br />");
    }
}

var myCar = new Car("Car");
myCar.Drive();

var mySuperCar = new SuperCar("SuperCar");
mySuperCar.Drive();
mySuperCar.Fly();

var myCar = new Car("Car");

```

[origin reference](http://stackoverflow.com/questions/892595/javascript-prototypal-inheritance)
[related reference](http://phrogz.net/JS/classes/OOPinJS2.html)


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
