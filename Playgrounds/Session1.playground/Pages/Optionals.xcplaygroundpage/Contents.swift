//: [Previous](@previous)

import Foundation
import UIKit

/*:
# Optionals

Used when a value may be absent

* denoted with a `?`
* think of it as a container, that either contains a value of a specific type, or there isn't a value at all, i.e. `nil`.
* will automatically be initialised as nil 

*/


var foo: String?
foo = "Hello"

/*:
## Optional binding & unwrapping

Because it's just a container, you can't actually call any functions on it without accessing the underlying value within. Hence unwrapping/binding
*/

//foo.isEmpty  // doesnt compile
foo?.isEmpty   // optional unwrapping
foo!.isEmpty   // forced unwrapping. Will crash if it is actually nil.


//: Bind the optional so that you can use it as a non-optional
if let foo = foo {
    foo.appending(" World")  //.stringByAppendingString(" World")
} else {
    print("is nil")
}


//: bind multiple optionals at a time with a condition
let title: String? = "Title"
let isLoaded: Bool? = false

if let title = title, let loaded = isLoaded, !loaded {
    //refresh the page.
}

//: different ways of including a conditional
let condition = true

if condition {
    if let title = title, let loaded = isLoaded {
        
    }
}
if condition, let title = title, let loaded = isLoaded, !loaded {
    
}


/*: 
The `guard` statement acts as an early return.
As a bonus, it also allows you to bind optionals too.
*/

//: Without guard, it would look like this:

func doSomethingWithoutGuard(title: String?, loaded: Bool?) {
    if title == nil || loaded == nil {
        return
    }
    if let title = title, let loaded = loaded {
        let printString = title + ": " + (loaded ? "on":"off")
        print(printString)
    }
}

//: With guard, it can be simplifed to:

func doSomething(title: String?, loaded: Bool?) {
    guard let title = title, let loaded = loaded else { return }
    let printString = title + ": " + (loaded ? "on": "off")
    print(printString)
}


/*:
## Implictly unwrapped optionals

Assumes the optional will always have a value all the time, due to the program's structure.
Note that if it is nil when you try to access its, you'll get a runtime crash.
*/

class TestViewController:UIViewController {

    // An outlet is a reference to an object which is established when a nib file or storyboard is loaded
    @IBOutlet var myView: UIView!
    
    override func viewDidLoad() {
        myView.updateConstraintsIfNeeded() //Don't need to unwrap myView
    }
}


/*:
## Optional chaining

Add ? after optional value to try to unwrap it, and gracefully returns nil.
Can be called on a nil, so it can be chained together.
*/

let myaccount: Account? = dummyAccount()

// instead of this...
var numTransactions: Int
if let myaccount = myaccount {
    if let transactions = myaccount.transactions {
        numTransactions = transactions.count
    }
} else {
    numTransactions = 0
}


// using optional chaining (and nil coalescing)
numTransactions = myaccount?.transactions?.count ?? 0

// note that a property accessed via optional chaining becomes optional (even if it isn't defined as optional)
let n = myaccount?.transactions?.count   // n is Int?


// since it returns nil, you can use if let
let myaccount2: Account? = dummyAccount2()
if let transactions = myaccount2?.transactions {
    print("numTransactions is \(transactions.count)")
} else {
    print("no transactions")
}






/*:
## Downcasting

Downcast to a subclass by using the typecast operator `as?` or `as!`

You'll often see this in JSON parsing
*/
typealias JSON = [String: Any]
let jsonString = "{ \"name\": \"Jemma Simmons\" }"
let jsonData = jsonString.data(using: .utf8)
let json: JSON = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! JSON
if let name = json["name"] as? String {
    print(name)
}




//: [Next](@next)
