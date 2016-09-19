//: [Previous](@previous)

import Foundation

//: # Functions

//: no parameters and no return value
func sayHello() {
    print("hello!")
}
sayHello()


//: with a return type
func sayHello2() -> String {
    return "hello!"
}
sayHello2()



/*:
## Parameters
*/

/*:
 All parameters are named
 */
func sayHelloTo(firstPerson: String, secondPerson: String) -> String {
    return "Hello \(firstPerson) and \(secondPerson)"
}
sayHelloTo(firstPerson: "Jack", secondPerson: "Jill")


//: Strive for fluent usage
func sayHello(to firstPerson:String, and secondPerson:String) -> String {
    return "Hello \(firstPerson) and \(secondPerson)"
}

sayHello(to: "Bill", and: "Melinda")

/*:
conversely, you can choose to hide the external names. 
This is considered bad practice, and should only be used in situations 
where omitting the param names actually makes it clearer,
(e.g. in some mathematical functions)
*/
func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
}
sum(1, 2)


//: ## Variadic parameters
func sum(numbers: Int...) -> Int {
    var result = 0
    for n in numbers {
        result += n
    }
    return result
}
sum(1, 2)
sum(numbers: 1, 2, 3)


//: ## default param values
func sayHello3(name: String = "Sir/Madam") -> String {
    return "Hello \(name)"
}
sayHello3()
sayHello3(name: "John")






/*:
### Homework Exercise

Write a function that will return the Nth fibonacci number.

The first two fibonacci numbers are 1 and the rest are the sum of the previous two.

1,1,2,3,5,8,13,etc

*/




//: [Next](@next)
