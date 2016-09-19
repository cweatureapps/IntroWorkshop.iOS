//: [Previous](@previous)

import UIKit

//: # Swift Types

//: ## Numbers

let count = 10

let amount = 10.23 

//: There is no type coercion of variables and constants in Swift, needs to explicitly create the correct type
//let anotherDouble: Double = count
//let amountTotal = amount * count
//let amountTotal = amount * Double(count)

//: However, literals are OK
let amountTotal2 = amount * 10

//: CGFloat is widely used by UIKit. It is a Float/Double depending on 32bit/64bit architecture

let width: CGFloat = 16
let frame = CGRect(x: 10, y: 10, width: width, height: 10)
let view = UIView(frame: frame)

//: For financial calcuations, use `Decimal` type to avoid floating point errors.

// Double will have floating point error
1.0 - 0.9 - 0.1 // -2.775557561562891e-17

// Decimal will give exact value
let decimal1 = Decimal(string: "1.0")!
let decimal2 = Decimal(string: "0.9")!
let decimal3 = Decimal(string: "0.1")!
let decimalAnswer = decimal1 - decimal2 - decimal3


//: ## Ranges

//: Ranges are used to represent an interval of values.

// Closed range
1...3 // 1,2,3

// Half open range (excludes the upper bound)
1..<3  // 1,2

// One sided range
..<2   // less than 2 (not including 2)
...2   // less than or equal to 2
2...   // more than 2


//: ## Strings

let message = "Hello World"

//: **Modifying a String**

message.lowercased()
message.uppercased()
message.isEmpty
"".isEmpty

// string interpolation
let color = "red"
let fruit = "apple"
"\(color) \(fruit)"

// format string
let formattedString = String(format: "color: %@, fruit: %@", color, fruit)


/*:
**Grapheme Cluster and character count**

  * callout(From Swift Programming Language book):
  Every instance of Swift's `Character` type represents a single *extended grapheme cluster*. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
 */
let snailAndWhale = "🐌🐋"
snailAndWhale.count
snailAndWhale.utf16.count
snailAndWhale.utf8.count

var word = "cafe"
word += "\u{301}"
word.count
word.utf16.count

//: **Substring**

let index = message.index(message.startIndex, offsetBy: 6)
message[index...]

let endIndex = message.index(message.startIndex, offsetBy: 5)
message[..<endIndex]


//: **Other useful functions**

// split
"once upon a midnight dreary".components(separatedBy: " ")

// trim
"   abc   ".trimmingCharacters(in: .whitespacesAndNewlines)

// replace
"123 456 789".replacingOccurrences(of: " ", with: "_")

//: **Multiline Strings**

let verse = """
    To be, or not to be - that is the question;
    Whether 'tis nobler in the mind to suffer
    The slings and arrows of outrageous fortune,
    Or to take arms against a sea of troubles,
    """
print(verse)


/*:
### Exercise

Use `String.replacingOccurrences(of:with:options:range:)` with the `.regularExpression` option to leave only numeric digits

*/

let s = " 123 asdf 45 678  9  "

// Solution...

s.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)


//: ## Collection types

//: ### Array

let messages1: [String] = ["foo", "bar"]
let messages = ["foo", "bar"]


// value semantics
var messages3 = messages
messages3[0] = "changed"
messages3
messages

// methods and properties
var animals: [String] = []
animals.append("dog")
animals.append("elephant")
animals.insert("mouse", at: 1)
animals.contains("dog")
animals.count

animals + ["cat"]  // + operator creates a new array
animals

// slicing using range
animals[1...]


//: ### Dictionary
var dictionary1: [String: Int] = ["a": 1, "b": 2]
var favouriteThings = ["cat": "wool", "dog": "bone"]


//: ## Tuples

let coordinate = (1,3)
coordinate.0
coordinate.1


let coordinate2 = (x: 1, y: 3)
coordinate2.x
coordinate2.y

typealias Coordinate = (x: Int, y: Int)
let coordinate3: Coordinate = (x: 100, y: 300)



/*:

## `Any` and `AnyObject`


Swift provides two special type aliases for working with non-specific types:
* `AnyObject` can represent an instance of any class type.
* `Any` can represent an instance of any type at all, including function types.

You'll most often encounter these type aliases during JSON parsing, and when interacting with older Objective-C APIs

*/


/*:

 ## `NSObject`
 
 `NSObject` is not a Swift type, but worth mentioning here.

 Unlike C# and Java where there is a root `Object` type, in Swift, it is not necessary to derive from a class like this.
 (Note in the above section, we said that `Any` and `AnyObject` are type aliases, i.e. they are not a superclass)

 However, Objective-C has this concept, and `NSObject` is the root class of most Objective-C class hierarchies, and provides the basic interface that works with the Objective-C runtime. You'll still often use features from `NSObject` as part of working with tranditional APIs, such as those found in `UIKit`.

*/




//: [Next](@next)
