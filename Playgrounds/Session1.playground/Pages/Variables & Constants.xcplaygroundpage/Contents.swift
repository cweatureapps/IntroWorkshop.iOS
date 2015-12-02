import Foundation

//: # Variables & Constants

//: ## Variables

var age: Int
var message: String = "Hello"

// Variable 'age' used before being initialized
// var age2: Int = age + 1

// Variables are mutable
message = message + " World!"


//: ## Constants

let year: Int = 2016
let message2: String = "Hello"

// Constants are immutable
// Cannot assign to value: 'year' is a 'let' constant
//year = year + 1


// compiler will warn you if you create a variable that should actually be immutable.
//func foobar() -> Int {
//    var n = 2   // Variable 'n' was never mutated; consider changing to 'let' constant
//    return n * 2
//}


//: ## Type Inference

let orange = "orange"
let numOranges = 12.0

// alt-click on a variable/constant to see the type

//: [Next](@next)
