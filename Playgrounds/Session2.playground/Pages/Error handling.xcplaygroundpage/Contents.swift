//: [Previous](@previous)

import Foundation
import UIKit

/*:
# Error Handling
*/

/*:
## Error Protocol
*/

/*
An Error is anything that conforms to the protocol 'Error'. However it does work particularly well if it is an Enum.
*/

enum LoadError: Error {
    case interrupted
    case fileNotFound
    case other(String)
}

/*:
## Handling your Errors
*/

//: If your function is going to throw an error and not handle it immediately, then you have to mark it as throws.
func throwableFunc() throws {
    throw LoadError.interrupted
}

/*:
Basic syntax is as follows:

    do {
        try somethingToTry()
    } catch pattern where condition {

    }
*/

func throwableFunc2() {
    do {
        try throwableFunc()
    } catch LoadError.interrupted {
        
    } catch LoadError.fileNotFound {
        
    } catch LoadError.other(let message) where message != ""  {
        // Only display message if it isn't empty
    
    } catch {

        /*
        Unfortunately, even though we know throwableFunc will only throw errors of type 'LoadError', the compiler does not. And because do-catch statements need to be exhaustive, we still need to have a default 'catch' statement here just in case it throws any other type of error.
        */
        
    }
}

//: Use the ? to create optional results
try? throwableFunc()

//: can use try! to not handle the error, but this can crash
// try! throwableFunc()


//: We can also do this
func throwableFunc3() {
    do {
        try throwableFunc()
    } catch let error as LoadError {
        switch error {
        case .fileNotFound: break
        case .interrupted: break
        case .other(_): break
        }
    } catch {
        
    }
}


/*:
NSError is a foundation object (from objective-c days) which conforms to the Error protocol.
When working with Objective-C APIs, you'll often get these errors.
*/
func foo() throws {
    throw NSError(domain: "foo", code: 100, userInfo: [NSLocalizedDescriptionKey: "something went wrong"])
}

do {
    try foo()
} catch let error as NSError {
    error.code
    error.localizedDescription
}



/*:
It is also a good idea to conform to CustomStringConvertible if you're going to create your own ErrorType,
so that you can add descriptive copy text to it.
*/

extension LoadError: CustomStringConvertible {
    var description: String {
        switch self {
        case .fileNotFound: return "LoadError: File Not Found"
        case .interrupted: return "LoadError: Interrupted"
        case .other(let message): return "LoadError: \(message)"
        }
    }
}


/*:
## Control Flow with Error Handling
*/

struct Item {
    var price: Double
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Chips": Item(price: 3.0, count: 5),
        "Chocolate": Item(price: 1.4, count: 8),
        "Cookie": Item(price: 2.0, count: 3)
    ]

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        //... etc...
    }

}

enum VendingMachineError: Error {
    case invalidSelection, outOfStock
}



/*:
## Defer
*/

/*
Use to schedule work at the end of the scope. This will trigger regardless of how the scope is ended, for example it will still trigger if an error is thrown and exited early.

It does however need to reach the defer statement in order for it to be scheduled and therefore triggered. It will also be triggered in the reverse order that they are scheduled (i.e. It's a stack).

Pop up the console and take a look and the order:
*/

func foo2() throws {
    print("1")
    defer {
        print("2")
    }
    
    // throw LoadError.other("boom")

    defer {
        print("3")
    }
    print("4")
}

try foo2()




//: [Next](@next)
