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
snailAndWhale.characters.count
snailAndWhale.utf16.count
snailAndWhale.utf8.count

var word = "cafe"
word += "\u{301}"
word.characters.count
word.utf16.count

//: **Substring and ranges**


let index = message.index(message.startIndex, offsetBy: 6)
message.substring(from: index)

let endIndex = message.index(message.startIndex, offsetBy: 2)
let range = message.startIndex..<endIndex
message.substring(with: range)

let fullRange = message.startIndex..<message.endIndex

//: **Other useful functions**

// split
"once upon a midnight dreary".components(separatedBy: " ")

// trim
"   abc   ".trimmingCharacters(in: .whitespacesAndNewlines)

// replace
"123 456 789".replacingOccurrences(of: " ", with: "_")



/*:
### Exercise

Use `String.replacingOccurrences(of:with:options:range:)` with the `.regularExpression` option to leave only numeric digits

*/

let s = " 123 asdf 45 678  9  "


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
* AnyObject can represent an instance of any class type.
* Any can represent an instance of any type at all, including function types.

You'll most often encounter `AnyObject` during JSON parsing, and when interacting with older Objective-C APIs


*/

//: [Next](@next)
