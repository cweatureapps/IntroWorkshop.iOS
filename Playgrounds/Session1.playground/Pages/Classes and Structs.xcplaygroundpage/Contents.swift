//: [Previous](@previous)

import Foundation

/*:
# Classes and Structures

These are the building blocks for your programs. You can add properties and methods to them. Very similar in syntax and usage.

The main differences:

* struct has value semantics, while classes have reference semantics
* classes allow inheritance

*/

//: Example structure

struct Point {
    var x: Int
    var y: Int

    func equals(point: Point) -> Bool {
        return point.x == x && point.y == y
    }
}

let p = Point(x: 1, y: 1)
p.x
p.y
let p2 = Point(x: 1, y: 2)
p.equals(p2)


//: Example class

class Dog {
    var breed: String
    init(breed: String) {
        self.breed = breed
    }
    func talk() -> String {
        return "Woof!"
    }
}

class Labrador: Dog {
    init() {
        super.init(breed: "Labrador")
    }

    override func talk() -> String {
        return "gimme the ball gimme the ball gimme the ball"
    }
}

let labby = Labrador()
labby.talk()

/*:

### Choosing between structs and classes

If you need a holder to encapsulate a number of values (e.g. models corresponding to server side data), structs are a good fit, as value semantics makes the program easier to understand.

However, there are situations when classes need to be used:

* when you need inheritance (either your models, or e.g. UIKit)
* when you actually want reference semantics
* when interacting with Objective-C (only supports classes)

A good approach is to start with structs, then move to classes if needed.



### Performance

You can assume the behaviour of value types is that they are always copied, but behind the scenes, this is optimised so that it is only copied on write/modification, so that there is no performance impact.


*/


//: [Next](@next)
