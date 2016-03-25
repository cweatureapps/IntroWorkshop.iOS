import Foundation

//: # Functional Programming
/*: 
## Filter

Takes a collection and outputs a collection of elements that pass a condition.
*/
let numbers = [1, 2, 3, 4, 5, 6]
let evenNumbers = numbers.filter { $0 % 2 == 0 }
evenNumbers

/*:
### Exercise 1

Create an array from the array below without any of the nil values.
*/

let possibleNumbers: [Int?] = [1, nil, 2, nil, nil, 3, 4, 5, 6, nil, 7, 8]


/*: 
## Map

Takes a collection and outputs another collection of the same size by applying some kind of transform to it.
*/
let doubledNumbers = numbers.map { $0 * 2 }
doubledNumbers

/*:
### Exercise 2

Create an array where every value from `numbers` is a formatted currency String to 2dp

i.e. we want ["$1.00", "$2.00", "$3.00", "$4.00", "$5.00", "$6.00"]
*/



/*:  
## Reduce

Reduce essentially takes a collection of elements, and outputs just one thing by combining all elements in the collection in some way.
*/

let sum = numbers.reduce(0){ $0 + $1 }
sum

/// Let's write that another way to make it more obvious

let initialValue = 0
numbers.reduce(initialValue, { previousResult, nextElement in
    return previousResult + nextElement
})

/*:
This is the worked solution:
 
    initialValue + (first element)     = 0  + 1 = 1
    (previous result) + (next element) = 1  + 2 = 3
    (previous result) + (next element) = 3  + 3 = 6
    (previous result) + (next element) = 6  + 4 = 10
    (previous result) + (next element) = 10 + 5 = 15
    (previous result) + (next element) = 15 + 6 = 21
*/


//: The real power of it comes when you start combining arrays together.  The first trick is that you can concat two arrays together. E.g.
[1] + [2] // [1,2]

//: Let's use reduce to repeat every number in the array

// expected: [1,1,2,2,3,3,4,4,5,5,6,6]

// Notice the intial value is an empty array
numbers.reduce([], { previousResult, nextElement in
    return previousResult + [nextElement] + [nextElement]
})


/*:
### Exercise 3

Another fairly common function in other languages is Flatten. Flatten essentially removes one layer of abstraction.

i.e. flattening [[1,2],[3,4],[[5]]] = [1,2,3,4,[5]]

Try to implement this using reduce.

Hint: alt-click on the `arr`, you'll see that it's [Array<NSObject>]. Flattening it will make it into [NSObject]
*/

let arr = [[1, 2], [3, 4], [[5]]]


/*:
## FlatMap

This is a combination of Map and Flatten.

Exercise 3 can actually be implemented as:
*/

let flattened = arr.flatMap { $0 }
flattened

/*:
Remember this list of optionals in exercise 1?
You can remove nils by using `flatmap`.
*/

let justInts = possibleNumbers.flatMap { $0 }
justInts


/*:
### Exercise 4

Return an array of emails from the `users` array by using `flatMap`
*/

struct Person {
    let name: String
    let emails: [String]
}

let users = [
    Person(name: "Jill", emails: ["Jill@example.com"]),
    Person(name: "Jack", emails: ["Jack@example.org", "Jack@home.example"]),
    Person(name: "Juliette", emails: ["Julie@example.org", "JJ@home.example"])
]


/*:
### Exercise 5

Using any combination of these functions, create an array with just the even numbers, but translated into english words

Expected result: 

["twelve", "eight", "twenty-two", "six"]

 */

// Hint:
NumberFormatter.localizedString(from: NSNumber(value: 1), number: .spellOut)

let someNumbers = [12, 3, 7, 8, 22, 15, 1, 6]



//: [Next](@next)


