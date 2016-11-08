//: [Previous](@previous)

import Foundation

/*:
# Extensions
Extensions add new functionality to an existing class, structure, enumeration or protocol.

(Note that they cannot add stored properties)
*/

extension Int {
    var isNegative: Bool {
        return self < 0
    }
}

3.isNegative
(-3).isNegative


/*:
### Exercise:

1. add `square` property to Double
2. add a `plus` method to Double

*/



// expected output

//8.0.square      // 64
//9.0.plus(4.0)   // 13


//: [Next](@next)
