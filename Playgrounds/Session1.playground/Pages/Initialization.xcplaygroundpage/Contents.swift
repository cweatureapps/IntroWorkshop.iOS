//: [Previous](@previous)
import Foundation

//: ![initializer delegation](initializerDelegation01_2x.png)

//: Example

struct Person: CustomStringConvertible {
    let firstName: String
    let lastName: String
    let age: Int

    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }

    init?(dictionary: [String: AnyObject]) {
        if let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let age = dictionary["age"] as? Int {

            self.firstName = firstName
            self.lastName = lastName
            self.age = age

            // for class, use convenience, and delegate across
//            self.init(firstName: firstName, lastName: lastName, age: age)
            return
        }
        return nil
    }

    var description: String {
        return "\(firstName) \(lastName) (\(age))"
    }
    
}

let bart = Person(firstName: "Bart", lastName: "Simpson", age: 12)


let json = [
    "firstName": "Lisa",
    "lastName": "Simpson",
    "age": 10
]
let lisa = Person(dictionary: json)



//: [Next](@next)
