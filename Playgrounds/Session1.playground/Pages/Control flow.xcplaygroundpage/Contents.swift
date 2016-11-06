import Foundation
import UIKit

//: [Previous](@previous)


var numbers = [1, 2, 3, 4]
var mammals = ["cat", "dog", "mouse"]
var favouriteThings = ["cat": "ball of yarn", "dog": "chew toy", "mouse": "cheese"]



/*:
## Conditionals

Notice that brackets are not required
*/


var temperature = 35
if temperature > 100 {
    print("boiling")
} else if temperature < 0 {
    print("freezing")
} else {
    print("liquid water")
}




/*:
## Loops
*/

print("close range, 1 to 5 inclusive")
for index in 1...5 {
    print(index)
}

print("half open range, does not include 5")
for i in 0 ..< 5 {
    print(i)
}

print("for-in loop with array")
for num in numbers {
    print(num)
}

print("for-in loop with dictionary")
for (animal, toy) in favouriteThings {
    print("\(animal)s like \(toy)")
}

//And there are while loops too
var i = 5
while i > 0 {
    i -= 1
}

i = 5
repeat {
    i -= 1
} while i > 0



/*:
### Exercise

Given an array of Ints, print out only the even
*/

let nums = [0,1,2,3,4,5,6,7,8,9,10]


/*:
## switch statement

Notice that there is no implicit fallthrough like many other languages.

Here are just some examples of what you can do with the pattern matching...
*/

// multiple cases separated using comma

let someCharacter: Character = "a"
switch someCharacter {
    case "a", "e", "i", "o", "u":
        print("vowel")
    default:
        print("consonant")
}

// ranges

let numberInTheBed = 1
switch numberInTheBed {
    case 2..<Int.max:
        print("roll over!")
    case 1:
        print("I'm lonely")
    default:
        print("not supported")
}

// tuples

let coordinate = (7,7)
switch coordinate {

    //match to exact value
    case (0, 0):
        print("origin")

    //bind the value
    case (let x, 0):
        print("on y axis, with x value of \(x)")

    // conditional
    case let (x, y) where x == y:
        print("slope is 1")

    default:
        print("other")
}

/*:
### Exercise

Given the following list of food, group them based on the `foodGroup`
*/

typealias Food = (name: String, foodGroup: String)

let foods: [Food] = [
    (name: "Carrot", foodGroup: "Vegetable"),
    (name: "Apple", foodGroup: "Fruit"),
    (name: "Beef", foodGroup: "Meat"),
    (name: "Chicken", foodGroup: "Meat"),
    (name: "Pear", foodGroup: "Fruit"),
    (name: "Celery", foodGroup: "Vegetable"),
    (name: "Oats", foodGroup: "Grains"),
    (name: "Milk", foodGroup: "Dairy"),
    (name: "Rice", foodGroup: "Grains")
]

var grains: [Food] = []
var meatAndDairy: [Food] = []
var fruitsAndVeges: [Food] = []

//: For example, grains should be `[("Oats","Grains"), ("Rice","Grains")]`



/*:
## Guard
Guards provide syntax for an early exit of a function

    guard condition else {
        // do something if condition fails
    }
*/

let message = [
    "errorMessage": "Something went wrong"
]

func printErrorMessage1(json: [String: String]) {
    if json["errorMessage"] != nil {
        print("not nil")
    }
}

func printErrorMessage2(json: [String: String]) {
    if json["errorMessage"] == nil {
        return
    }
    print("not nil")
}

func printErrorMessage3(json: [String: String]) {
    guard json["errorMessage"] != nil else { return }
    print("not nil")
}

printErrorMessage3(json: message)




//: [Next](@next)
