# Design Pattern - Builder

```csharp
interface
IPizza

interface
IPizzaBuilder
+ Set...(): IPizzaBuilder
+ GetPizza(): IPizza

class
AmericaPizza: IPizza

class
JapanPizza: IPizza

class
AmericaPizzaBuilder: IPizzaBuilder
- Create(): IPizza
+ Set...(): IPizzaBuilder
+ GetPizza(): IPizza

class
JapanPizzaBuilder: IPizzaBuilder
- Create(): IPizza
+ Set...(): IPizzaBuilder
+ GetPizza(): IPizza

class
PizzaShop
+ Constructor(IPizzaBuilder)
+ Make(): IPizzaBuilder
+ Sale(): IPizza

var americaPizza = new PizzaShop(new AmericaPizzaBuilder()).Make().GetPizza()
var japanPizza = new PizzaShop(new JapanPizzaBuilder()).Make().GetPizza()
```
