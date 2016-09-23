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

1. add `square` and `squareRoot` properties to Double. (Hint: `sqrt()`)
2. add a `plus` method to Double

*/


//------------

// solution

extension Double {
    var square: Double {
        return self * self
    }
    var squareRoot: Double {
        return sqrt(self)
    }
    func plus(_ b: Double) -> Double {
        return self + b
    }
}

//------------------


// expected output

9.0.squareRoot  // 3
8.0.square      // 64
9.0.plus(4.0)   // 13


//: [Next](@next)
