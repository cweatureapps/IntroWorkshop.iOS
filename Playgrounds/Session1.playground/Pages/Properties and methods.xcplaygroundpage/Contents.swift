//: [Previous](@previous)

import UIKit

/*:
# Properties

* stored properties
* computed properties
* property observers
* type properties

*/

struct Person {

    // stored properties may be constants or variables, and can be given a default value

    let firstName: String
    let lastName: String
    var age: Int = 0

    // read-only computed properties

    var fullName: String {
        return "\(firstName) \(lastName)"
    }

}

let person = Person(firstName: "John", lastName: "Smith", age: 30)
person.fullName

// ------------

class MyView: UIView {
    var label: UILabel = UILabel()

    // computed property with getter and setter

    var labelText: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }

    // property observer

    var labelText2: String? {
        willSet {
            print("about to set \(newValue)")
        }
        didSet {
            print("the previous value was \(oldValue)")
            print("the new value is \(labelText2)")
            label.text = labelText2
        }
    }
}


let v = MyView()
v.labelText2 = "foo"
v.labelText2 = "bar"

// ------------

// Type properties

class MyClass {
    struct Constants {

        static let width: CGFloat = 320
        static let height: CGFloat = 200

        static var area: CGFloat {
            return width * height
        }
    }

    struct OmnitureTags {
        static let foo = "something"
    }
}


/*:
# Methods

Classes, structures and enumerations can all define functions which are associated with a particular type. These can be either instance methods, or Type methods.
*/

/*: 
For simple methods in classes and structs, see the **Classes and Structs** examples on the [previous page](@previous)

They have the same syntax as global functions discussed earlier, but they are just defined inside a class, structure or enumeration.
*/


/*:
For structs, if the method changes itself, must be marked `mutating`
*/

struct Point: CustomStringConvertible {
    var x: Int
    var y: Int

    mutating func move(x: Int, y: Int) {
        self.x += x
        self.y += y
    }

    mutating func resetToOrigin() {
        self = Point(x: 0, y: 0)
    }

    var description: String {
        return "(\(x),\(y))"
    }
}

var point = Point(x: 1, y: 1)
point.move(x: 3, y: 4)
point.resetToOrigin()



/*:
Methods can be defined on the type itself, rather than on instances
*/

struct Helper {
    static func save(data: String) {
        UserDefaults.standard.set(data, forKey: "foo")
    }
}



//: [Next](@next)
