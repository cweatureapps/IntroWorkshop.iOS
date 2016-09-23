//: [Previous](@previous)

import UIKit

let numbers = [144, 64, 100, 361, 289, 121, 49, 196]


/*: 
# Closures

Self-contained blocks of functionality that can be passed around.
(They are somewhat similar to lambda expressions in C# and Java, 
and very similar to a javascript anonymous function callback.)

They are most often used in async APIs for a callback pattern,
where your callback closure is invoked on completion of some time consuming task.

*/


// The sort method, using a normal function

func descending(n1: Int, n2: Int) -> Bool {
    return n1 > n2
}
numbers.sorted(by: descending)

//---------------------

// closure syntax
numbers.sorted(by: { (n1: Int, n2: Int) -> Bool in
    return n1 > n2
})

// inferring type
numbers.sorted(by: { n1, n2 in
    return n1 > n2
})

// implicit return
let sorted = numbers.sorted(by: { n1, n2 in n1 > n2 })
sorted


// shorthand arguments
let sorted2 = numbers.sorted(by: { $0 > $1 })
sorted2


// trailing closure
let sorted3 = numbers.sorted { $0 > $1 }
sorted3


// operators are actually functions...
let sorted4 = numbers.sorted(by: >)
sorted4

//---------------------


/*:
### Exercise 1
Use the `map` and `sqrt` function to find the square root of each item, sorted descending

Hint: `sqrt(Double)` takes in a Double as a parameter, so you may need to construct a Double
*/



// solution
numbers.map {
    sqrt(Double($0))
}.sorted(by: >)




//---------------------


/*:
## Advanced: Capturing values

Further reading:

[Closures - Capturing Values](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html#//apple_ref/doc/uid/TP40014097-CH11-ID103)

*/
func incrementor() -> (() -> Int) {
    var i = 0  // this variable is captured by the closure
    return {
        i += 1
        return i
    }
}
let fn = incrementor()
fn()
fn()
fn()

let fn2 = fn  // note that closures are a reference type
fn2()

let fn3 = incrementor()
fn3()


//: [Next](@next)
