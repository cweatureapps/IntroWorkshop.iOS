import Foundation
import UIKit

/*:
# Enumerations

A common type for a group of related values.
*/

enum Direction {
    case north
    case south
    case east
    case west
}

//: can be written on a single line
enum Direction2 {
    case north, south, east, west
}

//: matching enum with a switch statement
let direction: Direction = .north
switch direction {
case .north:
    print("polar bears")
case .south:
    print("penguins")
case .east:
    print("sunrise")
case .west:
    print("sunset")
}


//: match single enum with an If statement
if case .north = direction {
    print("Hi Santa")
}

/*:
### Raw enums

Raw value enums are enums that are given a pre-defined value.

They can be strings, characters, or any of the integer or floating-point number types.
*/

enum HTTPStatusCode: Int {
    case ok = 200
    case movedPermanently = 301
    case notFound = 404
    case internalServerError = 500
}


// raw value enums automatically have a failable initializer `init?(rawValue:)`
let code = HTTPStatusCode(rawValue: 500)

// to get the raw value, use the `rawValue` property
code?.rawValue


// If you don't specify the value, there is a default automatically given

enum AnotherIntEnum: Int {
    case A, B , C
}
AnotherIntEnum.A.rawValue
AnotherIntEnum.B.rawValue
AnotherIntEnum.C.rawValue


enum AnotherStringEnum: String {
    case Apple, Banana , Carrot
}
AnotherStringEnum.Apple.rawValue
AnotherStringEnum.Banana.rawValue
AnotherStringEnum.Carrot.rawValue


/*:
### Associated value enums

They store additional custom information along with the case value, 
and permits this information to vary each time you use that case. Like an extra payload
*/

/*: 
A common example is a Result enum which encapsulates whether something was successful or whether it failed.
If it was successful, you include the data, in this case, a String.
If it failed, you include the error instead. (We'll discuss `Error` in more detail later)
*/
enum Result {
    case success(String)
    case failure(Error)
}


//: Pattern matching makes the calling code very concise

let result: Result = .success("This was the response from the server")
switch result {
case .success(let message):   // the let is used to get the associated value
    print("go this from the server: \(message)")
case .failure:
    print("something went wrong")
}



//: If you have multiple values, better to label them like a tuple
enum Trade {
    case Buy(stockCode: String, quantity: Int)
    case Sell(stockCode: String, quantity: Int)
}

let trade1 = Trade.Buy(stockCode: "CBA", quantity: 50)
let trade3 = Trade.Sell(stockCode: "ANZ", quantity: 40)
let trade2 = Trade.Sell(stockCode: "WBC", quantity: 40)

switch trade1 {
case .Buy(let stockCode, let quantity):    // this is how you access multiple associated values
    print("buy \(stockCode) \(quantity)")
case .Sell(let stockCode, let quantity):
    print("sell \(stockCode) \(quantity)")
}



/*: 
Further reading of different ways of using pattern matching for control flow here:

[http://austinzheng.com/2015/09/23/pmatch-control-flow/](http://austinzheng.com/2015/09/23/pmatch-control-flow/)
*/



/*:
Enums are very powerful, and can have 

* computed properties
* instance methods
* initializers
* can be extended
* can conform to protocols

*/


/*:
### Exercise

Implement an enum `Currency` that can be created from the currency code,
and has a property `symbol` which returns the symbol for the currency.

* AUD = $
* EUR = €
* GBP = £
* KRW = ₩

*/



enum Currency: String {
    case AUD
    case EUR
    case GBP
    case KRW

    var symbol: String {
        switch self {
        case .AUD: return "$"
        case .EUR: return "€"
        case .GBP: return "£"
        case .KRW: return "₩"
        }
    }
}


//: Now use the enum to convert a currency code to the currency symbol

let currencyCode = "GBP"

let currency = Currency(rawValue: currencyCode)
currency?.symbol  // "£"



//: [Next](@next)
