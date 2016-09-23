//: [Previous](@previous)

import Foundation
import UIKit

/*:
# Protocols

* A blueprint of methods, properties, etc that suit a particular requirement or piece of functionality. (Called an Interface in some other languages).

**Terminology**

* The protocol can be *adopted* by a class/struct/enum to provide a concrete implementation
* Any type that satisfies the requirements of the protocol is said to *conform* to the protocol

*/


protocol Shape {

    // type property
    static var numberOfSides: Int { get }

    // instance readonly property
    var area: Double { get }

    // instance property with both get and set
    var color: UIColor? { get set }

    // instance method
    func areaEquals(_ shape: Shape) -> Bool
}

/// implementation for Square
class Square: Shape {

    static var numberOfSides = 4

    var area: Double {
        return sideLength * sideLength
    }

    var color: UIColor?

    func areaEquals(_ shape: Shape) -> Bool {
        return self.area == shape.area
    }

    let sideLength: Double

    init(sideLength: Double) {
        self.sideLength = sideLength
    }
}

/// implementation for Circle
class Circle: Shape {

    static var numberOfSides = 1

    var area: Double {
        return 3.14 * radius * radius
    }

    var color: UIColor?

    func areaEquals(_ shape: Shape) -> Bool {
        return self.area == shape.area
    }

    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

}

// test code
Square.numberOfSides
let s = Square(sideLength: 5)
s.area
Square(sideLength: 6).areaEquals(s)

let c = Circle(radius: 3)
c.area


/*: 

## Checking for conformance

* `is` returns true or false
* `as?` optional downcast
* `as!` foced downcast

*/

//c is Square
//c as? Square
//s as? Square
//c as! Square

// The most common way to check for type conformance is with the `if let` statement and the optional downcast
func doSomethingWithShape(shape: Shape) {
    if let circle = shape as? Circle {
        print(circle.radius)
    } else if let square = shape as? Square {
        print(square.sideLength)
    }
}



//: You refer to the protocol as you would a Type

class ShapeRenderer {
    private var shapes: [Shape] = []
    func addShape(shape: Shape) {
        self.shapes.append(shape)
    }
    func render() {
        // draw the shapes
    }
}



/*:
## Protocol conformance
*/

protocol Aged {
    var age: Int { get set }
}

protocol Named {
    var fullName: String { get }
}

// adopt multiple protocols
struct Person: Named, Aged {
    let firstName: String
    let lastName: String
    var age: Int

    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

// You can adopt a protocol using an extension
extension Person: CustomStringConvertible {
    var description: String {
        return "\(fullName) (\(age))"
    }
}

let p = Person(firstName: "Rachel", lastName: "McAdams", age: 37)



// Protocol composition
func sayHappyBirthday(celebrator: Named & Aged) -> String {
    return "Happy Birthday \(celebrator.fullName), you're \(celebrator.age)"
}


sayHappyBirthday(celebrator: p)




/*:
## Protocol extension

Add a default implementation to all conforming types. 
You can add methods, or readonly properties.
Think of this is a mixin, allowing you to add pieces of default implementation.
*/

protocol Walkable {
    func walk()
}

extension Walkable {
    func walk() {
        print("one foot after another")
    }
}

extension Person: Walkable {}

p.walk()


/*:
You can also retrict the default implementation to be certain types.
You do this by adding a constraint to the protocol extension.

In the code below, the `talk()` implementation is only available types which conform to `Named`.
This allows your implementation to use certain things which are available. 
(in this case, the `fullName` property)
*/
protocol Talkable {
    func talk() -> String
}

extension Talkable where Self: Named {
    func talk() -> String {
        return "Hello! My name is \(fullName)"
    }
}

extension Person: Talkable {}

p.talk()






//: [Next](@next)
