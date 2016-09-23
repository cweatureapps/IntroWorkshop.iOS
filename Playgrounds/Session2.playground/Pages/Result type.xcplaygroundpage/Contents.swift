//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/*:
# Async methods - Result type
 
For async methods, the closure is called when the operation is completed.
* If successful, you want to pass some value back.
* If it fails, you want to pass an `Error` back.

This can be modelled by using an enum, generics, and Error

*/

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
}

enum MyError: Error {
    case general
}

func doSomethingAsync(completion: @escaping (Result<String, MyError>) -> Void) {
    print("wating 2 seconds...")
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        completion(.success("ok"))
    }
}

doSomethingAsync { result in
    switch result {
    case .success(let value):
        print(value)
    case .failure(let error):
        print("error")
    }
}

//: [Next](@next)
